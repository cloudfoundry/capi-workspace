#! /bin/bash

set -e

if ! which fly > /dev/null ; then
	destination=/usr/local/bin/fly
	if [ "$(uname)" = "Darwin" ]; then
		wget "https://capi.ci.cf-app.com/api/v1/cli?arch=amd64&platform=darwin" -O $destination
		chmod +x $destination
	else
		sudo wget "https://capi.ci.cf-app.com/api/v1/cli?arch=amd64&platform=linux" -O $destination
		sudo chmod +x $destination
	fi
fi
