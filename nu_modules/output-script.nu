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

# Generate a style log message to display and/or log
export def __display-message [
    level?: string  # Message level : alert, debug, error, info, successful_script, successful_step
    msg?: string    # Message to display
    ] {
    print (
        match $level {
            "alert"             => $'(ansi reset)(ansi bg_b) 🚨 (ansi yb)(date now | format date "%F %T") - ($msg)(ansi reset)'
            "debug"             => $'(ansi reset)(ansi bg_b) 🧐 (ansi wb)(date now | format date "%F %T") - ($msg)(ansi reset)'
            "error"             => $'(ansi reset)(ansi bg_b) 💥 (ansi rb)(date now | format date "%F %T") - ($msg)(ansi reset)'
            "info"              => $'(ansi reset)(ansi bg_b) 💬 (ansi wi)(ansi bo)(date now | format date "%F %T") - ($msg)(ansi reset)'
            "successful_script" => $'(ansi reset)(ansi bg_b) 🎉 (ansi gb)(date now | format date "%F %T") - ($msg)(ansi reset)'
            "successful_step"   => $'(ansi reset)(ansi bg_b) ✅ (ansi gb)(date now | format date "%F %T") - ($msg)(ansi reset)'
            _                   => $"(ansi reset)(ansi bg_b) 📬 You have a message ?(ansi reset)"
        }
    )
}

# Generate a line separator
export def __line-separator [
    separator_character = '-'
] {
    let line = ('' | fill --character $"($separator_character)" --width 80)
    print ($"(ansi reset)(ansi bg_b)(ansi mb)($line)(ansi reset)")
}
