#!/bin/bash

set -e

# Install x-code and accept license manually
function install_xcode {
	if [[ ! $(xcode-select -p)=='/Library/Developer/CommandLineTools' ]]; then
	  echo "Installing XCode developer tools"
	  sudo xcodebuild -license
	  xcode-select --install
	else
	  echo "XCode detected, skipping install"
	fi
}

# Install brew
function install_brew {
	if ! which brew > /dev/null ; then
                echo "Installing Homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

install_xcode
install_brew

