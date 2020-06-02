#!/bin/bash

set -e

core_capi_brewfile="${PWD}/Brewfile-core"
extra_capi_brewfile="${PWD}/Brewfile-extra"

echo "Installing from the Brewfile..."
brew update || echo "brew update failed, but continuing"
brew tap Homebrew/bundle
brew bundle --file "$core_capi_brewfile" || true

if [ "$FULL_CAPI_INSTALL" = true ]; then
    brew bundle --file "$extra_capi_brewfile" || true
fi

brew cleanup
