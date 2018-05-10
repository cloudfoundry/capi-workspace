#!/bin/bash

set -e

# Misc things can go here
TARGET=/usr/local/bin
SOURCE=$HOME/workspace/capi-workspace/scripts

if [ ! -f $SOURCE/fixcommitter ] ; then
	ln -s $SOURCE/fixcommitter $TARGET/fixcommitter
fi
