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

# Generate a message with or without timestamp to display or log 
export def __display-message [
    msg:        string  # Message to display
    --level:    string  # Message level : alert, debug, error, info, successful_script, successful_step
    --log               # Add timestamp
    ] {

    let timestamp = if $log {
        date now | format date "%F %T"
    }

    print (
        match $level {
            "alert"             => $'(ansi reset)(ansi bg_k) 🚨 (ansi yb)($timestamp) - ($msg) (ansi reset)'
            "debug"             => $'(ansi reset)(ansi bg_k) 🧐 (ansi wr)($timestamp) - ($msg) (ansi reset)'
            "error"             => $'(ansi reset)(ansi bg_k) 💥 (ansi rb)($timestamp) - ($msg) (ansi reset)'
            "info"              => $'(ansi reset)(ansi bg_k) 💬 (ansi wb)($timestamp) - ($msg) (ansi reset)'
            "successful_script" => $'(ansi reset)(ansi bg_k) 🎉 (ansi gb)($timestamp) - ($msg) (ansi reset)'
            "successful_step"   => $'(ansi reset)(ansi bg_k) ✅ (ansi gb)($timestamp) - ($msg) (ansi reset)'
            _                   => $'(ansi reset)(ansi bg_k) 📬 (ansi wi)($timestamp) - ($msg) (ansi reset)'
        }
    )
}

# Generate a horizontal rule
export def __display-horizontal-rule [
    separator_character = '―'   # Horizontal bar 
    --bg = "bg_k"               # Background color
    --fg = "lmb"                # Foreground color
] {
    let line = ('' | fill --character $"($separator_character)" --width 80)
    print ($"(ansi reset)(ansi $bg)(ansi $fg)($line)(ansi reset)")
}