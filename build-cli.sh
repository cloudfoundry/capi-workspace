#!/bin/bash

set -e

pushd ~/go/src/code.cloudfoundry.org/cli > /dev/null

  make build

popd > /dev/null
