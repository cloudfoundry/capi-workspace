#/bin/bash

if [[ ! $(which bundle) ]] || [[ "$(bundle -v)" != "Bundler version 2.1.4" ]]; then
	echo "Installing bundler"
	gem install bundler -v 2.1.4
fi
