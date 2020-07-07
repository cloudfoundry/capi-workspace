#!/bin/bash

set +e
defaults delete com.apple.dock persistent-apps >/dev/null 2>&1 || true
killall Dock
set -e
