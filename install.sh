#!/usr/bin/env bash

set -e

LOGFILE=$HOME/workspace/capi-workspace/launchagent-daily-install.log

function install {

if [ ! -t 1 ] ; then
  echo '=================================================================='
  date
  echo '=================================================================='
fi >> $LOGFILE

cd "$(dirname "$0")"

# first switch remote to https so that we can pull without keys in
git remote set-url origin https://github.com/cloudfoundry/capi-workspace

# make sure we're up to date
git pull

# restore remote to ssh
git remote set-url origin git@github.com:cloudfoundry/capi-workspace

# install brew and its packages
# source ./setup/brew.sh
# source ./setup/xcode.sh
# source ./brew-bundle.sh

# bash-it / terminal
source ./setup/bash.sh
source ./setup/bash-it.sh
source ./setup/custom-bash-it-plugins.sh
source ./setup/iterm2.sh
source ./setup/vim.sh
source ./setup/tmux.sh

# ruby setup
source ./setup/ruby.sh
source ./setup/bundler.sh

# git setup
source ./setup/git-config.sh
source ./setup/git-hooks.sh
source ./setup/git-author.sh

# update cred-alert-cli
source ./setup/update-cred-alert.sh

source ./setup/keyboard.sh
source ./setup/spectacle.sh

# Golang setup
source ./setup/go.sh

# Depends on existence of GOPATH, created earlier on
source ./clone-repos.sh

source ./setup/fly.sh

source ./setup/misc.sh

source ./setup/snyk.sh
# Add gem dependencies for CAPI-Workspace
bundle

echo "Please set your computer name using \"./setup/system-name.sh <name>\" if you have not already. Thanks!"
}


function open_log() {
  open $HOME/workspace/capi-workspace/launchagent-daily-install.log
}

function exit_successfully() {
  # clean up autoinstall logs on autoinstall success
  if [ ! -t 1 ] ; then
    echo -n > $LOGFILE
  fi

  echo "Successfully installed!"
}

trap '{ case $? in
   0) exit_successfully; exit 0;;
   *) open_log ; exit 0;;
 esac ; }' EXIT

install
