#!/bin/bash

set -e

if [ ! -d ~/workspace/pivotal_ide_prefs ]; then
	git clone https://github.com/pivotal/pivotal_ide_prefs.git ~/workspace/pivotal_ide_prefs
fi

pushd ~/workspace/pivotal_ide_prefs > /dev/null
	./cli/bin/ide_prefs install --ide=rubymine
popd > /dev/null
