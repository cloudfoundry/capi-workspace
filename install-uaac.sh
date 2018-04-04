#/bin/bash

if ! which bundle > /dev/null; then
	echo "Installing uaac"
	gem install cf-uaac
fi
