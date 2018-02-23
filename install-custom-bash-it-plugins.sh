#!/bin/bash

set -e

source ./helpers/bash-it-helpers.sh

for filepath in ~/workspace/capi-workspace/custom-bash-it-plugins/*; do
	enable_custom_bash_it_plugin $filepath
done
