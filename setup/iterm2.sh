#!/bin/bash
set -e

current_directory=$PWD
preferences_path="/Users/$(whoami)/Library/Preferences/com.googlecode.iterm2.plist"

if ! diff "${current_directory}/assets/com.googlecode.iterm2.plist" "${preferences_path}"; then
	cp -f "${current_directory}/assets/com.googlecode.iterm2.plist" "${preferences_path}"
fi
