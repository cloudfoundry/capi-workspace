#!/bin/bash

set -e

source "/usr/local/share/chruby/chruby.sh"
RUBY_VERSION="2.7.5"

if [ ! -e ~/.rubies/ruby-${RUBY_VERSION} ]; then 
	ruby-install --no-reinstall ruby ${RUBY_VERSION}
fi

echo "ruby-${RUBY_VERSION}" > ~/.ruby-version

#seems like we need to source twice to get the new ruby?
source "/usr/local/share/chruby/chruby.sh"

chruby ${RUBY_VERSION}
gem update --system
