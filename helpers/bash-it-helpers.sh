#!/bin/bash

set -e

function enable_bash_it_plugin {
	local plugin=$1
	pushd $BASH_IT/enabled > /dev/null
		if [ ! -e "./$plugin" ]; then
			echo "Enabling $plugin bash_it plugin"
			ln -s "$BASH_IT/plugins/available/$plugin"
		else
			echo "$plugin bash_it plugin already enabled"
		fi
	popd > /dev/null
}
