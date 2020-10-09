#!/bin/bash

set -e


core_capi_brewfile="${PWD}/Brewfile-core"
extra_capi_brewfile="${PWD}/Brewfile-extra"

osx_capi_brewfile="${PWD}/Brewfile-osx"

echo "Installing from the Brewfile..."
brew update || echo "brew update failed, but continuing"
brew tap Homebrew/bundle
if ! brew bundle check --file "$core_capi_brewfile"; then
    brew bundle --file "$core_capi_brewfile"
fi

if [ "$(uname)" = "Darwin" ]; then
    echo "Trying to install OSX forumalas"

    if ! brew bundle check --file "$osx_capi_brewfile"; then
        echo "Installing OSX specific Brew formulas"
        brew bundle --file "$osx_capi_brewfile"
    fi
fi

if [ "$FULL_CAPI_INSTALL" = true ]; then
    if ! brew bundle check --file "$extra_capi_brewfile"; then
        brew bundle --file "$extra_capi_brewfile"
    fi
fi

source "${PWD}/install-scripts/brew-cf-cli.sh"
