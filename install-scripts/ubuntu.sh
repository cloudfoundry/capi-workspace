#!/bin/bash
echo "Updating apt packages"
sudo apt update
echo "Upgrading Linux distribution"
sudo apt dist-upgrade -y

sudo apt install -y \
  python-pip \
  python-setuptools \
  mysql-server \
  postgresql \
  ruby \
  ruby-bundler
# install linux only dependencies here
# Install lastpass-cli from source (the Ubuntu package is broken)
echo "Installing lastpass-cli from source"
if [[ ! -d ~/workspace/lastpass-cli ]]; then
 pushd ~/workspace
  git clone https://github.com/lastpass/lastpass-cli.git
 popd
fi

# linuxbrew doesn't install git stuff where we expect it to
sudo ln -s /home/linuxbrew/.linuxbrew/share/git-core /usr/local/share/git-core

pushd ~/workspace/lastpass-cli
  sudo apt install -y openssl libcurl4-openssl-dev libxml2 libssl-dev libxml2-dev pinentry-curses xclip cmake build-essential pkg-config
  git pull
  cmake .
  make
  sudo make install
popd

# .config directory is required by lastpass-cli
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.local/share/lpass"
#sudo apt install universal-ctags

