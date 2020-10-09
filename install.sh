#!/usr/bin/env bash

set -e

: "${FULL_CAPI_INSTALL:=true}"

function install {

cd "$(dirname "$0")"

# first switch remote to https so that we can pull without keys in
git remote set-url origin https://github.com/cloudfoundry/capi-workspace

# make sure we're up to date
git pull

# restore remote to ssh
git remote set-url origin git@github.com:cloudfoundry/capi-workspace

source ./install-core.sh

# bash-it / terminal
source ./install-scripts/bash.sh
source ./install-scripts/bash-it.sh
source ./install-scripts/vim.sh
source ./install-scripts/tmux.sh

# git setup
source ./install-scripts/git-config.sh
source ./install-scripts/git-hooks.sh
source ./install-scripts/git-author.sh

# update cred-alert-cli
source ./install-scripts/update-cred-alert.sh

if [ "$(uname)" = "Darwin" ]; then
	echo "Installing OSX only scripts"
	source ./install-scripts/ide-prefs.sh
	source ./install-scripts/iterm2.sh
	source ./install-scripts/keyboard.sh
	source ./install-scripts/dock.sh
	source ./install-scripts/spectacle.sh
else
        source ./install-scripts/git-author-linux.sh
fi

source ./install-scripts/misc.sh

# Add gem dependencies for CAPI-Workspace
bundle

echo "Please set your computer name using \"./install-scripts/system-name.sh <name>\" if you have not already. Thanks!"
}

install
