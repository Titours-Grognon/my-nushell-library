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
use ../get-settings.nu *

__display-message --level info "Running tests..."

__display-horizontal-rule

__display-message --level info ("Test: load setting file" | str upcase)

let test_global = __get-settings --settings_file test-settings.toml
print $test_global

assert equal $"($test_global.void)" "{}"
assert equal $"($test_global.available)" "{test: OK}"

__display-message --level successful_step "Test: load setting file"

__display-horizontal-rule

__display-message --level info ("Test: load setting file with empty table" | str upcase)

let test_void = __get-settings void --settings_file test-settings.toml
print $test_void

assert equal ($test_void | describe) "record"
assert equal $"($test_void)" "{}"

__display-message --level successful_step "Test: load setting file with empty table"

__display-horizontal-rule

__display-message --level info ("Test: load setting file with data in table" | str upcase)

let test_available = __get-settings available --settings_file test-settings.toml
print $test_available

assert equal ($test_available.test) "OK"

__display-message --level successful_step "Test: load setting file with data in table"

__display-horizontal-rule

__display-message --level successful_script "Tests completed successfully"
