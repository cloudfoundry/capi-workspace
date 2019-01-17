#!/bin/bash

set -e

source ./helpers/clone.sh

pushd ~/workspace > /dev/null

	clone git@github.com:pivotal/pivotal_ide_prefs.git ~/workspace/pivotal_ide_prefs
	clone git@github.com:cloudfoundry/capi-release.git ~/workspace/capi-release develop
	clone git@github.com:cloudfoundry/capi-env-pool.git ~/workspace/capi-env-pool
	clone git@github.com:cloudfoundry/capi-ci.git ~/workspace/capi-ci
	clone git@github.com:cloudfoundry/capi-dockerfiles.git ~/workspace/capi-dockerfiles
	clone git@github.com:cloudfoundry/capi-ci-private.git ~/workspace/capi-ci-private
	clone git@github.com:cloudfoundry/cf-deployment.git ~/workspace/cf-deployment
	clone git@github.com:cloudfoundry/cli-private.git ~/workspace/cli-private
	clone git@github.com:cloudfoundry/cli-pools.git ~/workspace/cli-pools

	# clone golang repos and symlink them into the GOPATH
	clone git@github.com:cloudfoundry/cf-acceptance-tests.git ~/go/src/github.com/cloudfoundry/cf-acceptance-tests
	if [ ! -L ~/workspace/cf-acceptance-tests ]; then
		ln -s	$HOME/go/src/github.com/cloudfoundry/cf-acceptance-tests ~/workspace/cf-acceptance-tests
	fi

	clone git@github.com:cloudfoundry/sync-integration-tests.git ~/go/src/code.cloudfoundry.org/sync-integration-tests
  ln -sfn $HOME/go/src/code.cloudfoundry.org/sync-integration-tests ~/workspace/sync-integration-tests

	# clone git@github.com:cloudfoundry/capi-bara-tests.git ~/go/src/github.com/cloudfoundry/capi-bara-tests
	# if [ ! -L ~/workspace/capi-bara-tests ]; then
	# 	ln -s	$HOME/go/src/github.com/cloudfoundry/capi-bara-tests ~/workspace/capi-bara-tests
	# fi

	clone git@github.com:cloudfoundry/cli.git ~/go/src/code.cloudfoundry.org/cli
	if [ ! -L ~/workspace/cli ]; then
		ln -s	$HOME/go/src/code.cloudfoundry.org/cli/ ~/workspace/cli
	fi

popd > /dev/null
