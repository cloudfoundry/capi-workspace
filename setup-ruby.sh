#!/bin/bash

set -e

function enable_bash_it_plugin {
	local plugin=$1
	pushd $BASH_IT/enabled > /dev/null
		if [ ! -e "./$plugin" ]; then
			echo "Enabling $plugin bash_it plugin"
			ln -s $BASH_IT/plugins/available/chruby-auto.plugin.bash
		else
			echo "$plugin bash_it plugin already enabled"
		fi
	popd > /dev/null
}

if [ ! -e ~/.rubies/ruby-2.4.2 ]; then
	ruby-install ruby 2.4.2
fi
echo "ruby-2.4.2" > ~/.ruby-version
enable_bash_it_plugin chruby-auto.plugin.bash
