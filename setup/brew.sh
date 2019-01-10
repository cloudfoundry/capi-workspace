#!/bin/bash

set -e

# Install brew
function install_brew {
	if ! which brew > /dev/null ; then
                echo "Installing Homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
			</dev/null
	fi
	# to avoid ttyless complaints on brew update
	sudo chown -R $(whoami) /usr/local/sbin
}

# do not run in non-interactive contexts
if [ ! -t 1 ] ; then
  return
fi

install_brew
