#!/bin/bash

set -e

core_capi_brewfile="${PWD}/Brewfile-core"
extra_capi_brewfile="${PWD}/Brewfile-extra"

echo "Installing from the Brewfile..."
brew update || echo "brew update failed, but continuing"
brew tap Homebrew/bundle
if ! brew bundle check --file "$core_capi_brewfile"; then
    brew bundle --file "$core_capi_brewfile" || true
fi

if [ "$FULL_CAPI_INSTALL" = true ]; then
    if ! brew bundle check --file "$extra_capi_brewfile"; then
        brew bundle --file "$extra_capi_brewfile" || true
    fi
fi

brew cleanup
