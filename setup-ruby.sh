#!/bin/bash

set -e

source ./helpers/bash-it-helpers.sh

if [ ! -e ~/.rubies/ruby-2.4.2 ]; then
	ruby-install ruby 2.4.2
fi
echo "ruby-2.4.2" > ~/.ruby-version
ruby -e 'if (`gem --version`.chomp.split(".").map(&:to_i) <=> [2, 6, 14]) == -1 ; \
	system("gem install rubygems-update") ; \
	system("update_rubygems"); \
	system("gem update --system 2.6.14") \
end'
enable_bash_it_plugin chruby-auto
set +e
source ~/.bash_profile
set -e
chruby 2.4.2
