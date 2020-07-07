#! /bin/bash

set -e

if ! which fly > /dev/null ; then
	destination=/usr/local/bin/fly
	wget "https://capi.ci.cf-app.com/api/v1/cli?arch=amd64&platform=darwin" -O $destination
	chmod +x $destination
fi
