#!/bin/bash

set -ex

echo "Updating apt packages"
sudo apt update
echo "Upgrading Linux distribution"
sudo apt dist-upgrade -y

sudo apt install -y \
  build-essential \
  docker.io \
  libmysqlclient-dev \
  libpq-dev \
  libpq5 \
  libxslt-dev \
  mysql-server \
  postgresql \
  python-pip \
  python-setuptools

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - &&\
  sudo apt-get install -y nodejs nginx && npm install yarn -g

# fun dependencies
sudo apt install -y \
  cowsay \
  figlet \
  sl

# install linux only dependencies here
# Install lastpass-cli from source (the Ubuntu package is broken)
echo "Installing lastpass-cli from source"
if [[ ! -d ~/workspace/lastpass-cli ]]; then
 pushd ~/workspace
  git clone https://github.com/lastpass/lastpass-cli.git
 popd
fi

# linuxbrew doesn't install git stuff where we expect it to
sudo ln -sf /home/linuxbrew/.linuxbrew/share/git-core /usr/local/share/git-core

pushd /tmp/
  if ! command -v fd &> /dev/null
  then
    curl -LO https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
    sudo dpkg -i fd_8.2.1_amd64.deb
  fi

  if ! command -v ripgrep &> /dev/null
  then
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
    sudo dpkg -i ripgrep_12.1.1_amd64.deb
  fi


  if ! command -v ruby-install &>/dev/null
  then
    wget -O ruby-install-0.8.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.8.1.tar.gz
    tar -xzvf ruby-install-0.8.1.tar.gz
    cd ruby-install-0.8.1/
    sudo make install
  fi


  wget http://es.archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi7_3.3-4_amd64.deb
  sudo dpkg -i libffi7_3.3-4_amd64.deb


  wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
  tar -xzvf chruby-0.3.9.tar.gz
  cd chruby-0.3.9/
  sudo make install
  cd ..
  rm -r chruby-0.3.9/
popd

pushd ~/workspace/lastpass-cli
  sudo apt install -y openssl libcurl4-openssl-dev libxml2 libssl-dev libxml2-dev pinentry-curses xclip cmake build-essential pkg-config
  git clean -fd
  git checkout .
  git pull
  cmake .
  make
  sudo make install
popd




# .config directory is required by lastpass-cli
mkdir -p "${HOME}/.config"
mkdir -p "${HOME}/.local/share/lpass"
#sudo apt install universal-ctags

