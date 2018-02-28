#!/bin/bash

set -e

# install brew and its packages
source ./install-brew.sh
source ./install-xcode.sh
source ./brew-bundle.sh

# install specific version of consul that's compatible with cc bridge
# there's a tech forum item to discuss whether cc bridge tests should still rely on consul
source ./install-consul.sh

# bash-it / terminal
source ./setup-bash-it.sh
source ./setup-custom-bash-it-plugins.sh
source ./setup-iterm2.sh
source ./setup-vim.sh

# git setup
source ./setup-git-config.sh
source ./setup-git-duet.sh

# ruby setup
source ./setup-ruby.sh
source ./setup-rubymine.sh
source ./install-bundler.sh

source ./setup-keyboard.sh
source ./setup-spectacle.sh

# daemons to launch databases at startup
source ./setup-mysql.sh
source ./setup-postgres.sh


# Golang setup
source ./setup-go.sh

# Depends on existence of GOPATH, created earlier on
source ./clone-repos.sh

source ./setup-cats.sh

echo "Success!!"
