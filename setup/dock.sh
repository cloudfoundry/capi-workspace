#!/bin/bash

set +e
defaults delete com.apple.dock persistent-apps >/dev/null 2>&1 || true
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/System Preferences.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
killall Dock
set -e
