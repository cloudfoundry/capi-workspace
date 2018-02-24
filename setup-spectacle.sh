#!/bin/bash
current_directory=$PWD
preferences_path="/Users/$(whoami)/Library/Preferences/com.divisiblebyzero.Spectacle.plist"

echo $current_directory
echo $preferences_path

if [[ ! -e "${preferences_path}" ]]; then
	ln -s "${current_directory}/assets/com.divisiblebyzero.Spectacle.plist" "${preferences_path}"
fi
