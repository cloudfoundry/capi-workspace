#!/bin/bash

set -e

pushd ~/workspace/pivotal_ide_prefs > /dev/null
	./cli/bin/ide_prefs install --ide=rubymine
popd > /dev/null
