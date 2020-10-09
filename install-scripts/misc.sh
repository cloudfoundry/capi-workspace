#!/bin/bash

set -e

# Misc things can go here
TARGET=/usr/local/bin
SOURCE=$HOME/workspace/capi-release/scripts # notice this NOT capi-workspace, if you are adding content to this file (REFACTOR!)

if [ ! -h $TARGET/fixcommitter ] && [ ! -f $TARGET/fixcommitter ]; then
	sudo ln -s $SOURCE/fixcommitter $TARGET/fixcommitter
fi
