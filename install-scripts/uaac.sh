#/bin/bash

if ! which uaac > /dev/null; then
	echo "Installing uaac"
	gem install cf-uaac
fi
