#!/bin/bash

if [ -e ~/workspace/cf-acceptance-tests/integration_config.json ]; then
	echo "Placing sample integration config into CATs repo"
	cp assets/integration_config.json ~/workspace/cf-acceptance-tests/integration_config.json
fi
