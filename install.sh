#!/bin/bash

set -e
set -x

# install brew and its packages
source ./install-brew.sh
source ./install-xcode.sh
source ./brew-bundle.sh

source ./setup-bash-it.sh
source ./setup-git-config.sh
source ./setup-git-duet.sh
source ./clone-repos.sh
source ./setup-ruby.sh
source ./setup-rubymine.sh
source ./setup-keyboard.sh
source ./setup-custom-bash-it-plugins.sh
source ./setup-mysql.sh
source ./setup-postgres.sh
source ./setup-iterm2.sh
source ./setup-go.sh
source ./setup-vim.sh
source ./setup-spectacle.sh

echo "Success!!"
