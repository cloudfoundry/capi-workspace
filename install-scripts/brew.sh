#!/bin/bash

set -e

# Install brew
function install_brew {
	if ! which brew > /dev/null ; then
                echo "Installing Homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
			</dev/null
	fi
	# to avoid ttyless complaints on brew update
	sudo mkdir -p /usr/local/sbin
	sudo chown -R $(whoami) /usr/local/sbin
	if [ "$(uname)" = "Linux" ]; then
		if ! brew; then
			echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> $HOME/.profile
			eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
		fi
	fi
}

install_brew
