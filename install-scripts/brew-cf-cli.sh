#!/bin/bash
# both versions of cf-cli conflict on trying to link `cf`,
# which can cause the install via Brewfile to fail

brew install cf-cli@7

# this will exit 1 since v7 already has the link
brew install cf-cli@6 
cli6_version="$(brew list --versions | grep cf-cli@6 | cut -d' ' -f2)"
sudo ln -snf  "$(brew --cellar cf-cli@6)/$cli6_version/bin/cf" /usr/local/bin/cf6
