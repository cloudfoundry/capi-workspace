#!/bin/bash

set -e

source ./helpers/bash-it-helpers.sh

function install_bash_it {
	if ! grep -q bash_it ~/.bash_profile ; then
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

enable_bash_it_plugin fasd
enable_bash_it_completion defaults
enable_bash_it_completion git
enable_bash_it_completion ssh
enable_bash_it_alias bundler
enable_bash_it_alias git
