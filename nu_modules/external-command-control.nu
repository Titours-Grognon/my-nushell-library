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

# External control of nu commands
export def __external-command-control [
    external_command:   string
    control_command:    string = "standard" # Control option: analyze (allows to process data return), continue (allows to continue script execution in case of error), debug or standard
    shell?:             string = "bash"
] {

    if not ($control_command in ["analyze" "continue" "debug" "standard"]) {
        __display-message error "Control parameter not managed"
        exit 1
    }
    
    let external_command_result = run-external "/usr/bin/env" $shell "-c" $external_command | complete

    if ($control_command == "analyze") {
        return (command-analyze $external_command $external_command_result)
    }

    if ($control_command == "debug") {
        return (command-debug $external_command $external_command_result)
    }
   
    if ($external_command_result.exit_code != 0) {
        command-stop $external_command $external_command_result $control_command
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
    __display-message "external_command"
    $external_command_result
}

def command-debug [
    external_command: string
    external_command_result: record
] {
    __display-message info $external_command    
    __display-message info $"Return code: ($external_command_result.exit_code)"
    if ($external_command_result.stdout | is-not-empty) {
        __display-message debug $"Stdout:\n($external_command_result.stdout)"
    }
    if ($external_command_result.stderr | is-not-empty) {
        __display-message debug $"Stderr:\n($external_command_result.stderr)"
    }
}

def command-stop [
    external_command: string
    external_command_result: record
    control_command: string
] {
    __display-message alert $external_command
    __display-message error "Not properly execution of the external command"
    __display-message debug $"($external_command_result.stderr)"
    if ($control_command != "continue") {
        exit 1
    }
}

def command-success [
    external_command: string
    external_command_result: record
] {
    __display-message info $external_command    
    __display-message successful_step "Execution successfully"
}