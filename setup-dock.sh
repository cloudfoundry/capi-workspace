#!/bin/bash

set +e
defaults delete com.apple.dock persistent-apps && killall Dock
set -e
