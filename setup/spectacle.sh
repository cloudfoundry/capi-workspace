#!/bin/bash
set -e

current_directory=$PWD
preferences_path="/Users/$(whoami)/Library/Preferences/com.divisiblebyzero.Spectacle.plist"

echo $current_directory
echo $preferences_path

cp -f "${current_directory}/assets/com.divisiblebyzero.Spectacle.plist" "${preferences_path}"
