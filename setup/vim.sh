#!/bin/bash
set -e

# this is where new luan nvim installs to, so delete it to revert
rm -rf ~/.config/nvim/ ~/.vim* ~/.local/share/nvim/

git clone https://github.com/luan/nvim ~/.config/nvim

echo "Update pip..."
pip3 install --upgrade pip

echo "Install python-client for neovim..."
pip3 install --upgrade neovim

echo "Add yamllint for neomake..."
pip3 install -q yamllint

mkdir -p ~/.config/nvim/user
pushd ~/.config/nvim/user
	ln -sf ~/workspace/capi-workspace/assets/*.vim .
popd
