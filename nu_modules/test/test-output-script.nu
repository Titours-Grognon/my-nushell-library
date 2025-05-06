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

#+----------+#
#| *MODULE* |#
#+----------+#

use std/assert
use ../output-script.nu *

__display-message info "Running tests..."

__line-separator

__display-message info ("Test: Output message - ALERT" | str upcase)

let alert_icon = "🚨"
let alert_text = "ALERT"
let alert_result = do {nu -c "use ../output-script.nu ; output-script __display-message alert 'ALERT'"} | complete
print $alert_result

assert str contains $alert_result.stdout $alert_icon
assert str contains $alert_result.stdout $alert_text

__display-message successful_step "Test: Output message - ALERT"

__line-separator

__display-message info ("Test: Output message - DEBUG" | str upcase)

let debug_icon = "🧐"
let debug_text = "DEBUG"
let debug_result = do {nu -c "use ../output-script.nu ; output-script __display-message debug 'DEBUG'"} | complete
print $debug_result

assert str contains $debug_result.stdout $debug_icon
assert str contains $debug_result.stdout $debug_text

__display-message successful_step "Test: Output message - DEBUG"

__line-separator

__display-message info ("Test: Output message - ERROR" | str upcase)

let error_icon = "💥"
let error_text = "ERROR"
let error_result = do {nu -c "use ../output-script.nu ; output-script __display-message error 'ERROR'"} | complete
print $error_result

assert str contains $error_result.stdout $error_icon
assert str contains $error_result.stdout $error_text

__display-message successful_step "Test: Output message - ERROR"

__line-separator

__display-message info ("Test: Output message - INFO" | str upcase)

let info_icon = "💬"
let info_text = "INFO"
let info_result = do {nu -c "use ../output-script.nu ; output-script __display-message info 'INFO'"} | complete
print $info_result

assert str contains $info_result.stdout $info_icon
assert str contains $info_result.stdout $info_text

__display-message successful_step "Test: Output message - INFO"

__line-separator

__display-message info ("Test: Output message - SUCCESSFUL SCRIPT" | str upcase)

let successful_script_icon = "🎉"
let successful_script_text = "SUCCESSFUL SCRIPT"
let successful_script_result = do {nu -c "use ../output-script.nu ; output-script __display-message successful_script 'SUCCESSFUL SCRIPT'"} | complete
print $successful_script_result

assert str contains $successful_script_result.stdout $successful_script_icon
assert str contains $successful_script_result.stdout $successful_script_text

__display-message successful_step "Test: Output message - SUCCESSFUL SCRIPT"

__line-separator

__display-message info ("Test: Output message - SUCCESSFUL STEP" | str upcase)

let successful_step_icon = "✅"
let successful_step_text = "SUCCESSFUL STEP"
let successful_step_result = do {nu -c "use ../output-script.nu ; output-script __display-message successful_step 'SUCCESSFUL STEP'"} | complete
print $successful_step_result

assert str contains $successful_step_result.stdout $successful_step_icon
assert str contains $successful_step_result.stdout $successful_step_text

__display-message successful_step "Test: Output message - SUCCESSFUL STEP"

__line-separator

__display-message info ("Test: Output message - DEFAULT" | str upcase)

let default_icon = "📬"
let default_text = "You have a message ?"
let default_result = do {nu -c "use ../output-script.nu ; output-script __display-message lambda 'You have a message ?'"} | complete
print $default_result

assert str contains $default_result.stdout $default_icon
assert str contains $default_result.stdout $default_text

__display-message successful_step "Test: Output message - DEFAULT"

__line-separator

__display-message info ("Test: Line separator" | str upcase)

let separator_character = "-"
let separator_character_result = do {nu -c "use ../output-script.nu ; output-script __line-separator"} | complete
print $separator_character_result

assert str contains $separator_character_result.stdout $separator_character

__display-message successful_step "Test: Line separator"

__line-separator

__display-message successful_script "Tests completed successfully"
