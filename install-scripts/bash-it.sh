#!/bin/bash

set -e

function install_bash_it {
	if [ ! -e ~/.bash_it ] ; then
		echo "Installing bash_it"
		git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
	else	
		echo "Updating bash_it"
		pushd ~/.bash_it > /dev/null
			git checkout .
			git pull -r
		popd > /dev/null
	fi
	~/.bash_it/install.sh --silent
}
install_bash_it

# remove annoying aliases
if grep -q "alias q='exit'" ~/.bash_it/aliases/available/general.aliases.bash ; then
	sed -i -e '/alias q=.exit./d' ~/.bash_it/aliases/available/general.aliases.bash
fi
if grep -q "alias k='clear'" ~/.bash_it/aliases/available/general.aliases.bash ; then
	sed -i -e '/alias k=.clear./d' ~/.bash_it/aliases/available/general.aliases.bash
fi

source ./helpers/bash-it-helpers.sh

enable_bash_it_plugin fasd
enable_bash_it_plugin history
enable_bash_it_plugin chruby-auto

enable_bash_it_completion defaults
enable_bash_it_completion git
enable_bash_it_completion ssh

enable_bash_it_alias bundler
enable_bash_it_alias git

rm -rf "${BASH_IT}/custom/"
for filepath in ~/workspace/capi-workspace/bash-it/*; do
	enable_custom_bash_it_plugin $filepath
done

for filepath in ~/workspace/capi-workspace/lib/*; do
	enable_custom_bash_it_plugin $filepath
done
