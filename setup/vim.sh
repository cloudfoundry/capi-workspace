#!/bin/bash
set -e

if [[ ! -d ~/.vim ]]; then
	curl vimfiles.luan.sh/install | bash
fi

pushd ~/.vim
if git remote -v | grep -q luan &> /dev/null; then
	echo $PWD
	./install
fi
popd

echo "Update pip..."
pip3 install --upgrade pip

echo "Install python-client for neovim..."
pip3 install neovim

echo "Add yamllint for neomake..."
pip3 install -q yamllint
