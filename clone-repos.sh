#!/bin/bash

set -e

function clone {
	local repo=$1
	local destination=$2
	local branch=${3:-master}

	if [ ! -d $destination ]; then
		echo "Cloning $destination"
		git clone $repo $destination --branch $branch
	else
		echo "$destination already present, skipping"
	fi
}

pushd ~/workspace > /dev/null

	clone git@github.com:pivotal/pivotal_ide_prefs.git ~/workspace/pivotal_ide_prefs
	clone git@github.com:cloudfoundry/capi-release.git ~/workspace/capi-release develop
	clone git@github.com:cloudfoundry/capi-env-pool.git ~/workspace/capi-env-pool
	clone git@github.com:cloudfoundry/capi-ci.git ~/workspace/capi-ci
	clone git@github.com:cloudfoundry/capi-dockerfiles.git ~/workspace/capi-dockerfiles
	clone git@github.com:cloudfoundry/capi-ci-private.git ~/workspace/capi-ci-private
	clone git@github.com:cloudfoundry/cf-deployment.git ~/workspace/cf-deployment

	# clone golang repos and symlink them into the GOPATH
	clone git@github.com:cloudfoundry/cf-acceptance-tests.git ~/go/src/github.com/cloudfoundry/cf-acceptance-tests
	if [ ! -L ~/workspace/cf-acceptance-tests ]; then
		ln -s	/Users/pivotal/go/src/github.com/cloudfoundry/cf-acceptance-tests ~/workspace/cf-acceptance-tests
	fi

	clone git@github.com:cloudfoundry/sync-integration-tests.git ~/go/src/github.com/cloudfoundry/sync-integration-tests
	if [ ! -L ~/workspace/sync-integration-tests ]; then
		ln -s	/Users/pivotal/go/src/github.com/cloudfoundry/sync-integration-tests ~/workspace/sync-integration-tests
	fi

	clone git@github.com:cloudfoundry/cli.git ~/go/src/github.com/code.cloudfoundry.org/cli
	if [ ! -L ~/workspace/cli ]; then
		ln -s	/Users/pivotal/go/src/github.com/code.cloudfoundry.org/cli/ ~/workspace/cli
	fi

	# perm stuff
	clone git@github.com:cloudfoundry-incubator/perm-ci.git ~/workspace/perm-ci
	clone git@github.com:cloudfoundry-incubator/perm-release.git ~/workspace/perm-release

popd > /dev/null
