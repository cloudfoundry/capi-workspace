#!/bin/bash

set -e

source ./helpers/clone.sh
source ./helpers/disable-cred-hook.sh

pushd ~/workspace > /dev/null
	clone git@github.com:cloudfoundry/capi-release.git ~/workspace/capi-release develop
	clone git@github.com:cloudfoundry/capi-env-pool.git ~/workspace/capi-env-pool
	disable_cred_hook ~/workspace/capi-env-pool
	clone git@github.com:cloudfoundry/capi-ci.git ~/workspace/capi-ci
	clone git@github.com:cloudfoundry/capi-dockerfiles.git ~/workspace/capi-dockerfiles
	clone git@github.com:cloudfoundry/capi-ci-private.git ~/workspace/capi-ci-private
	disable_cred_hook ~/workspace/capi-ci-private
	clone git@github.com:cloudfoundry/cf-deployment.git ~/workspace/cf-deployment
	clone git@github.com:cloudfoundry/cf-for-k8s.git ~/workspace/cf-for-k8s

	# clone golang repos and symlink them into the GOPATH
	clone git@github.com:cloudfoundry/cf-acceptance-tests.git ~/go/src/github.com/cloudfoundry/cf-acceptance-tests
	if [ ! -L ~/workspace/cf-acceptance-tests ]; then
		ln -sf	$HOME/go/src/github.com/cloudfoundry/cf-acceptance-tests ~/workspace/cf-acceptance-tests
	fi

	clone git@github.com:cloudfoundry/capi-bara-tests.git ~/go/src/github.com/cloudfoundry/capi-bara-tests
	if [ ! -L ~/workspace/capi-bara-tests ]; then
		ln -sf	$HOME/go/src/github.com/cloudfoundry/capi-bara-tests ~/workspace/capi-bara-tests
	fi
popd > /dev/null
