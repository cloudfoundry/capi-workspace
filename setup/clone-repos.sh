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

function disable_cred_hook {
  mkdir -p "${1}/.git/hooks"
  cat > "${1}/.git/hooks/post-merge" << EOT
#!/usr/bin/env bash

# Override the default hook that complains about credentials

exit 1
EOT
  chmod +x "${1}/.git/hooks/post-merge"
}

pushd ~/workspace > /dev/null
	clone git@github.com:pivotal/pivotal_ide_prefs.git ~/workspace/pivotal_ide_prefs
	clone git@github.com:cloudfoundry/capi-release.git ~/workspace/capi-release develop
	clone git@github.com:cloudfoundry/capi-env-pool.git ~/workspace/capi-env-pool
	clone git@github.com:cloudfoundry/capi-ci.git ~/workspace/capi-ci
	clone git@github.com:cloudfoundry/capi-dockerfiles.git ~/workspace/capi-dockerfiles
	clone git@github.com:cloudfoundry/capi-ci-private.git ~/workspace/capi-ci-private
	clone git@github.com:cloudfoundry/cf-deployment.git ~/workspace/cf-deployment
	clone git@github.com:cloudfoundry/cf-for-k8s.git ~/workspace/cf-for-k8s
	clone git@github.com:cloudfoundry/cf-acceptance-tests.git ~/go/src/github.com/cloudfoundry/cf-acceptance-tests
	clone git@github.com:cloudfoundry/sync-integration-tests.git ~/go/src/code.cloudfoundry.org/sync-integration-tests
	clone git@github.com:cloudfoundry/capi-bara-tests.git ~/go/src/github.com/cloudfoundry/capi-bara-tests
	clone git@github.com:cloudfoundry/cli.git ~/go/src/code.cloudfoundry.org/cli

	disable_cred_hook ~/workspace/capi-env-pool
	disable_cred_hook ~/workspace/capi-ci-private

	# clone golang repos and symlink them into the GOPATH
	ln -sf	$HOME/go/src/github.com/cloudfoundry/cf-acceptance-tests ~/workspace/cf-acceptance-tests
	ln -sfn $HOME/go/src/code.cloudfoundry.org/sync-integration-tests ~/workspace/sync-integration-tests
	ln -sf	$HOME/go/src/github.com/cloudfoundry/capi-bara-tests ~/workspace/capi-bara-tests
	ln -sf	$HOME/go/src/code.cloudfoundry.org/cli/ ~/workspace/cli
popd > /dev/null
