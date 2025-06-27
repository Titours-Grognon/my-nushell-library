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

#+--------+#
#| *MAIN* |#
#+--------+#

use std/assert
use ../output-script.nu *
use ../external-command-control.nu *

__display-message --level info "Running tests..."

__display-horizontal-rule

__display-message --level info ("Test: unknown control mode" | str upcase)

let test_control_mode_unknown = do --ignore-errors {nu -c "use ../external-command-control.nu; external-command-control __external-command-control 'ls' 'mode'"} | complete
print $test_control_mode_unknown

assert equal $test_control_mode_unknown.exit_code 1

__display-message --level successful_step "Test: unknown control mode"

__display-horizontal-rule

__display-message --level info ("Test: valid command in debug mode" | str upcase)

let test_control_mode_debug_with_valid_command = do --ignore-errors {nu -c "use ../external-command-control.nu; external-command-control __external-command-control 'ls' 'debug'"} | complete
print $test_control_mode_debug_with_valid_command

assert equal $test_control_mode_debug_with_valid_command.exit_code 0

__display-message --level successful_step "Test: valid command in debug mode"

__display-horizontal-rule

__display-message --level info ("Test: not valid command in debug mode" | str upcase)

let test_control_mode_debug_with_not_valid_command = do --ignore-errors {nu -c "use ../external-command-control.nu; external-command-control __external-command-control 'ls --not-valid-parameter' 'debug'"} | complete
print $test_control_mode_debug_with_not_valid_command

assert equal $test_control_mode_debug_with_not_valid_command.exit_code 0

__display-message --level successful_step "Test: not valid command in debug mode"

__display-horizontal-rule

__display-message --level info ("Test: not valid command" | str upcase)

let test_not_valid_command = do --ignore-errors {nu -c "use ../external-command-control.nu; external-command-control __external-command-control 'ls --not-valid-parameter'"} | complete
print $test_not_valid_command

assert equal $test_not_valid_command.exit_code 1

__display-message --level successful_step "Test: not valid command"

__display-horizontal-rule

__display-message --level info ("Test: valid command" | str upcase)

let test_valid_command = do --ignore-errors {nu -c "use ../external-command-control.nu; external-command-control __external-command-control 'ls -1'"} | complete
print $test_valid_command

assert equal $test_valid_command.exit_code 0

__display-message --level successful_step "Test: valid command"

__display-horizontal-rule

__display-message --level successful_script "Tests completed successfully"
