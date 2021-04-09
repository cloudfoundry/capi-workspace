#!/usr/bin/env bash

set -e

: "${FULL_CAPI_INSTALL:=true}"

function install {

cd "$(dirname "$0")"

# first switch remote to https so that we can pull without keys in
git remote set-url origin https://github.com/cloudfoundry/capi-workspace

# make sure we're up to date
git pull

# restore remote to ssh
git remote set-url origin git@github.com:cloudfoundry/capi-workspace

source ./install-core.sh
source ./install-extras.sh

# Add gem dependencies for CAPI-Workspace
bundle

echo "Please set your computer name using \"./install-scripts/system-name.sh <name>\" if you have not already. Thanks!"
}

install
