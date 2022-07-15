#!/bin/sh

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
# dependencies to run tests
sudo DEBIAN_FRONTEND=noninteractive apt install build-essential postgresql libpq-dev mysql-server libmysqlclient-dev zip unzip nodejs npm -y
# ruby dependencies - this is to keep noninteractive mode on ruby-install command
sudo DEBIAN_FRONTEND=noninteractive apt install bison libffi-dev libgdbm-dev libncurses-dev libncurses5-dev libreadline-dev libyaml-dev m4 -y
# install golang for things we use golang for
sudo DEBIAN_FRONTEND=noninteractive apt install golang -y
# install dependencies for luan's neovim config
sudo apt install ripgrep fd-find -y
# clean up anything not needed
sudo apt autoremove -y

# make workspace
mkdir ~/workspace

# tmux setup with luan
cd ~/workspace
git clone https://github.com/luan/tmuxfiles.git
cd tmuxfiles
./install
cd ../..

# neovim (there is no vim) need at least 7.0 neovim for luan vim config
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb -y
rm nvim-linux64.deb
git clone https://github.com/luan/nvim ~/.config/nvim

# setup mysql
sudo service mysql start
sudo service mysql status # might need loop here depending how long status takes
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"

# setup postgres
sudo sed -i 's/peer/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
sudo sed -i 's/md5/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
sudo service postgresql restart

# ruby-install
wget -O ruby-install-0.8.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.8.3.tar.gz
tar -xzvf ruby-install-0.8.3.tar.gz
cd ruby-install-0.8.3/
sudo make install
ruby-install -V
cd ..
rm -rf ruby-install-*

# install ruby 3.1
ruby-install 3.1

# chruby
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install
cd ..
rm -rf chruby-*

# add chruby to shell
cat >> ~/.$(basename $SHELL)rc <<EOF
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
EOF
exec $SHELL
cat >> ~/.ruby-version <<EOF
3.1
EOF
chruby

# clone things into workspace
cd ~/workspace
git clone git@github.com:cloudfoundry/capi-release.git
cd capi-release
./scripts/update
cd ..
