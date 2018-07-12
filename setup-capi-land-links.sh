#!/bin/bash

declare -a capi_links=("board"
"chris"
"greg"
"mike"
"tim"
"video")

# open each link in Safari do it's Spotlight-indexed
echo "Indexing the following links in Safari:"
for link in "${capi_links[@]}"
do
  echo "${link}.capi.land"
  open -a safari http://$link.capi.land
done

# close Safari
osascript -e 'quit app "Safari"'
