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
        __display-message --level error $"No settings files"
        exit 1
    }

    if (($settings_file | path type) != "file") {
        __display-message --level error $"($settings_file) not found"
        exit 1
    }

    if ($table | is-empty) {
        try {
            open $settings_file
        } catch {|error|
            __display-message --level error $"($error.msg)"
            exit 1
        }
    } else {
        try {
            open $settings_file | get $table
        } catch {|error|
            __display-message --level error $"($error.msg)"
            exit 1
        }
    }
}