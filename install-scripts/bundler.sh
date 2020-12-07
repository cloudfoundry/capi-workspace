#/bin/bash

if [[ ! $(which bundle) ]] || [[ "$(bundle -v)" != "Bundler version 1.17.3" ]]; then
	echo "Installing bundler"
	gem install bundler -v 1.17.3
fi
