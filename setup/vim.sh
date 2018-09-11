#!/bin/bash
set -e

if [[ ! -d ~/.config/nvim ]]; then
	git clone https://github.com/luan/nvim ~/.config/nvim
	echo "installing custom settings"
	mkdir -p $HOME/.config/nvim/user
	ln -s $HOME/workspace/capi-workspace/assets/*.vim $HOME/.config/nvim/user
fi

pushd ~/.config/nvim
	git pull
popd

echo "Update pip..."
pip3 install --upgrade pip

echo "Install python-client for neovim..."
pip3 install neovim

echo "Add yamllint for neomake..."
pip3 install -q yamllint

