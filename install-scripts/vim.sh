#!/bin/bash
set -e

grep -q "github.com/luan/nvim" ~/.config/nvim/.git/config ||
	((chmod -f -R +w $HOME/.vim/gopath/pkg/mod/golang.org/x || true) ; rm -rf ${HOME}/.config/nvim ${HOME}/.vim* ${HOME}/.local/share/nvim &&
	git clone https://github.com/luan/nvim ~/.config/nvim)

echo "Install python-client for neovim..."
pip install --upgrade neovim
pip install --upgrade pynvim

echo "Add yamllint for neomake..."
pip install -q yamllint

mkdir -p ~/.config/nvim/user
pushd ~/.config/nvim/user
	ln -sf ~/workspace/capi-workspace/assets/*.vim .
popd
