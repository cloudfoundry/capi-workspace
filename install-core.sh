#!/usr/bin/env bash

##################################
# Core CAPI workspace installation
#
# The current goals listed in README.md are stale. This script aims
# to represent the most minimal, objective representation of what it
# means to develop on CAPI projects.
#
# Ultimately, this means stripping away a lot of excess configuration
# and utilities.
##################################

: "${FULL_CAPI_INSTALL:=false}"

if [ "$(uname)" = "Darwin" ]; then
	IS_OSX=true
else
	IS_OSX=false
	./install-scripts/ubuntu.sh
fi
# install brew and its packages
source ./install-scripts/brew.sh
if [ "$IS_OSX" = true ]; then
	source ./install-scripts/xcode.sh
else
	echo "Skipping Xcode installation for non OSX install"
fi
source ./install-scripts/brew-bundle.sh
echo "Installing ruby"
# ruby setup
source ./install-scripts/ruby.sh
source ./install-scripts/bundler.sh
echo "Installing databases"
# daemons to launch databases at startup
source ./install-scripts/mysql.sh
source ./install-scripts/postgres.sh

# Golang setup
source ./install-scripts/go.sh

# Depends on existence of GOPATH, created earlier on
source ./install-scripts/clone-repos.sh

# Concourse "fly"
source ./install-scripts/fly.sh
