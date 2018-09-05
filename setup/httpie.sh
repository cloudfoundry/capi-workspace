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
    echo "Getting code.cloudfoundry.org/cli/plugin..."
    go get code.cloudfoundry.org/cli/plugin
    echo "Cloning cf-httpie cli plugin..."
    clone git@github.com:zrob/cfhttp-plugin.git ~/workspace/cfhttp-plugin
    pushd cfhttp-plugin > /dev/null
    echo "Building cf-httpie plugin..."
    go build

    echo "Installing cf-httpie plugin..."
    cf install-plugin -f ./cfhttp-plugin
    popd > /dev/null
popd > /dev/null
