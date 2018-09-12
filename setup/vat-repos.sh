#!/bin/bash

set -e

source ./helpers/clone.sh

pushd ~/workspace > /dev/null
	clone git@github.com:cloudfoundry/cli-private.git ~/workspace/cli-private
popd > /dev/null
