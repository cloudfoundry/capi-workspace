#!/bin/bash

set -e

# Misc things can go here
TARGET=/usr/local/bin
SOURCE=$HOME/workspace/capi-release/scripts # notice this NOT capi-workspace, if you are adding content to this file (REFACTOR!)

if [ ! -f $TARGET/fixcommitter ] ; then
	ln -s $SOURCE/fixcommitter $TARGET/fixcommitter
fi
