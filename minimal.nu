#!/usr/bin/env nu
# (‾)-'"""""'-(‾)
#  /           \
# /   Ō  ●  Ō   \
# \   "( - )"   /
#  '-.._____..-'

#+--------+#
#| *INFO* |#
#+--------+#

#+-----------------+#
#| *CONFIGURATION* |#
#+-----------------+#

const bin_path = path self | path dirname

const root_path = $bin_path | path parse | get parent

const basename_script = path self | path basename | path parse | get stem

const file_hierarchy = if (($bin_path | path parse | get stem) == "bin") {
    # Applies [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/fhs.shtml)
    # to use script since the - /usr/local
    #   /usr/local
    #   ├── bin
    #   │  └── script-name.nu
    #   ├── etc
    #   │  └── script-name
    #   │     └── settings.toml
    #   └── lib
    #      └── script-name
    #         ├── module-<aaa>.nu
    #         ├── [...]
    #         └── module-<zzz>.nu
    {
        settings_path: ([$root_path etc $basename_script settings.toml] | path join),
        modules_path: ([$root_path lib $basename_script] | path join)
    }
} else {
    # Tree structure for local usage of script :
    #   .
    #   ├── script-name.nu
    #   ├── nu_modules
    #   │  ├── module-<aaa>.nu
    #   │  ├── [...]
    #   │  └── module-<zzz>.nu
    #   └── settings.toml
    {
        settings_path: ([$bin_path settings.toml] | path join),
        modules_path: ([$bin_path nu_modules] | path join)
    }
}

#+----------+#
#| *IMPORT* |#
#+----------+#

use ($file_hierarchy | get modules_path) *
