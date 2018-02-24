#!/bin/bash

if [[ ! -d ~/.vim ]]; then
	curl vimfiles.luan.sh/install | bash
fi

pushd ~/.vim
if git remote -v | grep -q luan &> /dev/null; then
	echo $PWD
	./install
fi
popd
