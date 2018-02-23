#!/bin/bash

set -e

source ./helpers/bash-it-helpers.sh

if [ ! -e ~/.rubies/ruby-2.4.2 ]; then
	ruby-install ruby 2.4.2
fi
echo "ruby-2.4.2" > ~/.ruby-version
enable_bash_it_plugin chruby-auto
