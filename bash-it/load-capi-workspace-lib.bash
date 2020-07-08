#!/bin/bash

set -e

source ~/workspace/capi-workspace/helpers/bash-it-helpers.sh

for filepath in ~/workspace/capi-workspace/lib/*; do
	source $filepath
done