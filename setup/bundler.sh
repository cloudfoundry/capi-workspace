#/bin/bash

if ! which bundle > /dev/null; then
	echo "Installing bundler"
	gem install bundler
fi
