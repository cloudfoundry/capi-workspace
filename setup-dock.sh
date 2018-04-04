#!/bin/bash

set +e
defaults delete com.apple.dock persistent-apps >/dev/null 2>&1 || true
# Default height probably floor(160 / 2 - 11) = 69
defaults write com.apple.dock tilesize -int 29
killall Dock
set -e
