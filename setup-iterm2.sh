#!/bin/bash
current_directory=$PWD
preferences_path="/Users/$(whoami)/Library/Preferences/com.googlecode.iterm2.plist"

echo $current_directory
echo $preferences_path

ln -s "${current_directory}/assets/com.googlecode.iterm2.plist" "${preferences_path}"
