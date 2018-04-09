#!/bin/bash

set -e

function install_bash_it {
	if [ -z "$BASH_IT" ] ; then
		echo "Installing bash_it"
		if [ ! -e ~/.bash_it ] ; then
			git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
		fi
		~/.bash_it/install.sh --silent
	else
		echo "bash_it already installed"
	fi
}

install_bash_it

source ./helpers/bash-it-helpers.sh

enable_bash_it_plugin fasd
enable_bash_it_plugin history
enable_bash_it_completion defaults
enable_bash_it_completion git
enable_bash_it_completion ssh
enable_bash_it_alias bundler
enable_bash_it_alias git
