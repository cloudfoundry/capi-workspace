#!/bin/bash

set -e

# Install x-code and accept license manually
# We basically do this solely to get git
function install_xcode {
	if [[ ! $(xcode-select -p)=='/Library/Developer/CommandLineTools' ]]; then
	  echo "Installing XCode developer tools"
	  sudo xcodebuild -license
	  xcode-select --install
	else
	  echo "XCode detected, skipping install"
	fi
}

install_xcode
