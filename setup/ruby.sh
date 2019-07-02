#!/bin/bash

set -e

source ./helpers/bash-it-helpers.sh

RUBY_VERSION="2.5.5"

if [ ! -e ~/.rubies/ruby-${RUBY_VERSION} ]; then
	ruby-install ruby ${RUBY_VERSION}
fi

echo "ruby-${RUBY_VERSION}" > ~/.ruby-version

ruby -e 'if (`gem --version`.chomp.split(".").map(&:to_i) <=> [2, 6, 14]) == -1 ; \
	system("gem install rubygems-update") ; \
	system("update_rubygems"); \
	system("gem update --system 2.6.14") \
end'

enable_bash_it_plugin chruby-auto

set +e
source ~/.bash_profile
set -e

source /usr/local/share/chruby/chruby.sh

chruby ${RUBY_VERSION}
