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

use output-script.nu *

#+----------+#
#| *MODULE* |#
#+----------+#

# Get parameters from a toml file
export def __get-settings [
    table?: string              # Extract collection of key/value pairs
    --settings_file: path = ""  # Configuration file in TOML format
] {

    if ($settings_file | is-empty) {
        __display-message error $"No settings files"
        return false
    }

    if (($settings_file | path type) != "file") {
        __display-message error $"($settings_file) not found"
        return false
    }

    if ($table | is-empty) {
        try {
            open $settings_file
        } catch {|error|
            __display-message error $"($error.msg)"
            false
        }
    } else {
        try {
            open $settings_file | get $table
        } catch {|error|
            __display-message error $"($error.msg)"
            false
        }
    }
}