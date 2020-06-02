#!/bin/sh

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

# install brew and its packages
source ./setup/brew.sh
source ./setup/xcode.sh
source ./brew-bundle.sh

# ruby setup
source ./setup/ruby.sh
source ./setup/bundler.sh
