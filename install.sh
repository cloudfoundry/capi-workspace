#!/bin/bash

set -e

function install {
# install brew and its packages
source ./install-brew.sh
source ./install-xcode.sh
source ./brew-bundle.sh
source ./install-bbl.sh

# install specific version of consul that's compatible with cc bridge
source ./install-consul.sh

# bash-it / terminal
source ./setup-bash-it.sh
source ./setup-custom-bash-it-plugins.sh
source ./setup-iterm2.sh
source ./setup-vim.sh

# git setup
source ./setup-git-config.sh
source ./setup-git-duet.sh
source ./setup-git-hooks.sh

# ruby setup
source ./setup-ruby.sh
source ./install-bundler.sh
source ./install-uaac.sh

# ide prefs
source ./setup-ide-prefs.sh

source ./setup-keyboard.sh
source ./setup-dock.sh
source ./setup-spectacle.sh

# daemons to launch databases at startup
source ./setup-mysql.sh
source ./setup-postgres.sh

# Golang setup
source ./setup-go.sh

# Depends on existence of GOPATH, created earlier on
source ./clone-repos.sh

source ./setup-cats.sh

source ./install-fly.sh

source ./setup-cron.sh

source ./setup-misc.sh
}

function open_picklecat() {
  open http://dn.ht/picklecat/
}

trap '{ case $? in
   0) echo "Success!" ;;
   *) open_picklecat ; exit 0;;
 esac ; }' EXIT

install
