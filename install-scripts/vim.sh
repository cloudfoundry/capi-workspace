#!/bin/bash
set -e

grep -q "github.com/luan/nvim" ~/.config/nvim/.git/config ||
	((chmod -f -R +w $HOME/.vim/gopath/pkg/mod/golang.org/x || true) ; rm -rf ${HOME}/.config/nvim ${HOME}/.vim* ${HOME}/.local/share/nvim &&
	git clone https://github.com/luan/nvim ~/.config/nvim)

echo "Install python-client for neovim..."
python3 -m pip install --user --upgrade pynvim

echo "Add yamllint for neomake..."
pip3 install -q yamllint

mkdir -p ~/.config/nvim/user
pushd ~/.config/nvim/user
	ln -sf ~/workspace/capi-workspace/assets/*.vim .
popd

nvim +UpdateRemotePlugins +qall
nvim +GoInstallBinaries +qall
