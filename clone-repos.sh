#!/bin/bash

set -e

function clone {
	local repo=$1
	local destination=$2
	local branch=${3:-master}

	if [ ! -d $destination ]; then
		echo "Cloning $destination"
		git clone $repo $destination --branch $branch
	else
		echo "$destination already present, skipping"
	fi
}

pushd ~/workspace > /dev/null

	clone git@github.com:pivotal/pivotal_ide_prefs.git ~/workspace/pivotal_ide_prefs
	clone git@github.com:cloudfoundry/capi-release.git ~/workspace/capi-release develop

popd > /dev/null
