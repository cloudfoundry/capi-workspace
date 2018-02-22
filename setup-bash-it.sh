#!/bin/bash

set -e

source ./helpers/bash-it-helpers.sh

function install_bash_it {
	if ! type bash_it > /dev/null 2>&1 ; then
		echo "Installing bash_it"
		if [ ! -e ~/.bash_it ] ; then
			git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
		fi
		~/.bash_it/install.sh --silent
		source ~/.bash_profile
	else
		echo "bash_it already installed"
	fi
}

install_bash_it

enable_bash_it_plugin fasd.plugin.bash
