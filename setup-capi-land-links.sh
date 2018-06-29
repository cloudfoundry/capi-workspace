#!/bin/bash

declare -a capi_links=("board.capi.land"
"chris.capi.land"
"greg.capi.land"
"tim.capi.land"
"video.capi.land")

# open each link in Safari do it's Spotlight-indexed
for link in "${capi_links[@]}"
do
  open -a safari http://$link
done

# close Safari
osascript -e 'quit app "Safari"'
