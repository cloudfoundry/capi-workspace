#/bin/bash

if ! which bundle > /dev/null; then
	echo "Installing bundler"
	gem install bundler -v 1.17.3
fi
