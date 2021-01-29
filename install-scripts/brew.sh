#!/bin/bash

set -e

# Install brew
function install_brew {
	if [ "$(uname)" = "Linux" ]; then
		if ! which brew > /dev/null ; then
			echo "Installing Homebrew"
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)" \
				</dev/null
		fi

		# to avoid ttyless complaints on brew update
		sudo mkdir -p /usr/local/sbin
		sudo chown -R $(whoami) /usr/local/sbin
		if ! brew; then
			echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/pivotal/.profile
			eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
		fi
	else
		if ! which brew > /dev/null ; then
			echo "Installing Homebrew"
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
				</dev/null
		fi

		# to avoid ttyless complaints on brew update
		sudo mkdir -p /usr/local/sbin
		sudo chown -R $(whoami) /usr/local/sbin
	fi
}

install_brew
