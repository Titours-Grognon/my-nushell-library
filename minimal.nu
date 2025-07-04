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

const script_path = path self | path dirname

const directory_script_path = $script_path | path parse | get parent

const script_basename = path self | path basename | path parse | get stem

const file_hierarchy = if ($script_path  == "/usr/local/bin") {
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
        settings_path: ([$directory_script_path etc $script_basename settings.toml] | path join),
        modules_path: ([$directory_script_path lib $script_basename] | path join)
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
        settings_path: ([$script_path settings.toml] | path join),
        modules_path: ([$script_path nu_modules] | path join)
    }
}

#+----------+#
#| *IMPORT* |#
#+----------+#

use $file_hierarchy.modules_path

#+--------------------+#
#| Script description |#
#+--------------------+#
def main [
    --show_env  # Show script configuration environment
] {
    if $show_env {
        __display-horizontal-rule
        __display-message --level info $"Path to script : \n\t\t($script_path)"
        __display-message --level info $"Path to directory parent script : \n\t\t($directory_script_path)"
        __display-message --level info $"Path to configuration file : \n\t\t($file_hierarchy.settings_path)"
        __display-message --level info $"Path to module folder of script : \n\t\t($file_hierarchy.modules_path)"
        __display-horizontal-rule
    }
}