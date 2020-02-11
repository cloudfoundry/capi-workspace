#!/bin/bash

set -e

if [ ! -d ~/workspace/git-hooks-core ]; then
  echo "Installing global git hooks & their dependencies..."

  # install cred-alert-cli as it is a dependency
  os_name=$(uname | awk '{print tolower($1)}')
  curl -o cred-alert-cli \
    https://s3.amazonaws.com/cred-alert/cli/current-release/cred-alert-cli_${os_name}
  chmod 755 cred-alert-cli
  mv cred-alert-cli /usr/local/bin # <= or other directory in ${PATH}

  # clone our branch of git-hooks-core @ team/capi branch
  git clone -b "team/capi" https://github.com/pivotal-cf/git-hooks-core ~/workspace/git-hooks-core
fi

# add our hooks
set +e
if ! git config --global --get core.hookspath; then
  set -e
  git config --global --add core.hooksPath ~/workspace/git-hooks-core
fi

${HOME}/workspace/capi-release/src/cloud_controller_ng/scripts/install-pre-commit.sh
