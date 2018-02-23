#!/bin/bash

set -e
set -x

source ./initial-bootstrap.sh
source ./brew-bundle.sh
source ./setup-bash-it.sh
source ./clone-repos.sh
source ./setup-ruby.sh
source ./setup-rubymine.sh
source ./setup-keyboard.sh
source ./install-custom-bash-it-plugins.sh

echo "Success!!"
