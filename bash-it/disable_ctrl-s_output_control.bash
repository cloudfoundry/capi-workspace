# disable START/STOP output control
# frees up CTRL+S for bash history forward search
if [ -n "$BASH" ]; then
    stty -ixon
fi
