#!/bin/bash

set -e

capi_brewfile="${PWD}/Brewfile"

echo "Installing from the Brewfile..."
brew update || echo "brew update failed, but continuing"
brew tap Homebrew/bundle
brew bundle --file "$capi_brewfile" || true
brew cleanup
