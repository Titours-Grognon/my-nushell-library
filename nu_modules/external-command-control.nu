#!/usr/bin/env nu
# (‾)-'"""""'-(‾)
#  /           \
# /   Ō  ●  Ō   \
# \   "( - )"   /
#  '-.._____..-'

#+--------+#
#| *INFO* |#
#+--------+#
#
# Module for controling the output of external commands such as *bash*
#
#+-----------------+#
#| *CONFIGURATION* |#
#+-----------------+#

use output-script.nu *

#+----------+#
#| *PUBLIC* |#
#+----------+#

# Run an external command based on a mode :
# 
# - analyze     (allows to process data return)
# - continue    (allows to continue script execution in case of error)
# - debug       (display all information)
# - standard    (display command success or failure)
export def __external-command-control [
    external_command: string    # Command to execute
    --mode: string = "standard" # Mode option: analyze, continue, debug, quiet or standard
    --shell: string = "bash"    # Command line interpreter
] {

    if not ($mode in ["analyze" "continue" "debug" "standard"]) {
        __display-message --level error "Control parameter not managed"
        exit 1
    }
    
    let external_command_result = run-external "/usr/bin/env" $shell "-c" $external_command | complete

    if ($mode == "analyze") {
        return (command-analyze $external_command $external_command_result)
    }

    if ($mode == "debug") {
        return (command-debug $external_command $external_command_result)
    }
   
    if ($external_command_result.exit_code != 0) {
        command-stop $external_command $external_command_result $mode
    } else {
        command-success $external_command $external_command_result
    }
}

#+-----------+#
#| *PRIVATE* |#
#+-----------+#

def command-analyze [
    external_command: string
    external_command_result: record
]: nothing -> record {
    $external_command_result
}

def command-debug [
    external_command: string
    external_command_result: record
] {
    __display-message --level info $external_command    
    __display-message --level info $"Return code: ($external_command_result.exit_code)"
    if ($external_command_result.stdout | is-not-empty) {
        __display-message --level debug $"Stdout:\n($external_command_result.stdout)"
    }
    if ($external_command_result.stderr | is-not-empty) {
        __display-message --level debug $"Stderr:\n($external_command_result.stderr)"
        exit 1
    }
}

def command-stop [
    external_command: string
    external_command_result: record
    mode: string
] {
    __display-message --level alert $external_command
    __display-message --level error "Not properly execution of the external command"
    __display-message --level debug $"($external_command_result.stderr)"
    if ($mode != "continue") {
        exit 1
    }
}

def command-success [
    external_command: string
    external_command_result: record
] {
    __display-message --level info $external_command    
    __display-message --level successful_step "Execution successfully"
}