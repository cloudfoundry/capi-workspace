#!/bin/sh

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
# dependencies to run tests
sudo DEBIAN_FRONTEND=noninteractive apt install build-essential postgresql libpq-dev mysql-server libmysqlclient-dev zip unzip nodejs npm -y
# ruby dependencies - this is to keep noninteractive mode on ruby-install command
sudo DEBIAN_FRONTEND=noninteractive apt install bison libffi-dev libgdbm-dev libncurses-dev libncurses5-dev libreadline-dev libyaml-dev m4 -y
# rust/git-together dependency
sudo DEBIAN_FRONTEND=noninteractive apt install pkg-config -y
# install dependencies for target_cf helper
sudo DEBIAN_FRONTEND=noninteractive apt install jq -y
# install dependencies for capi-team-playbook which apparently needs a config directory
sudo DEBIAN_FRONTEND=noninteractive apt install lastpass-cli
mkdir -p ~/.config
# clean up anything not needed
sudo apt autoremove -y

# make workspace
mkdir -p ~/workspace

# clone things into workspace
cd ~/workspace
git clone git@github.com:cloudfoundry/capi-release.git --branch develop
git clone git@github.com:cloudfoundry/capi-ci.git
cd capi-release
./scripts/update
cd ..

# tmux setup with luan
cd ~/workspace
git clone https://github.com/luan/tmuxfiles.git
cd tmuxfiles
./install
cd ../..

# neovim (there is no vim) need at least 7.0 neovim for luan vim config
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo DEBIAN_FRONTEND=noninteractive apt install ./nvim-linux64.deb -y
rm nvim-linux64.deb
nvim -v
# install dependencies for luan's neovim config
sudo DEBIAN_FRONTEND=noninteractive apt install ripgrep fd-find bat python3-neovim -y
# get luan vim config
git clone https://github.com/luan/nvim ~/.config/nvim

# setup mysql
sudo service mysql start
sudo service mysql status # might need loop here depending how long status takes
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"

# setup postgres
sudo sed -i 's/peer/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
sudo sed -i 's/md5/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
sudo service postgresql restart

# install golang to get latest
wget https://go.dev/dl/go1.19.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.19.5.linux-amd64.tar.gz
# set go and cf cli on path
cat >> ~/.$(basename $SHELL)rc <<EOF
PATH="$PATH:$HOME/workspace/cli/out:/usr/local/go/bin"
EOF
rm go1.19.5.linux-amd64.tar.gz

# ruby-install
wget -O ruby-install-0.8.5.tar.gz https://github.com/postmodern/ruby-install/archive/v0.8.5.tar.gz
tar -xzvf ruby-install-0.8.5.tar.gz
cd ruby-install-0.8.5/
sudo make install
ruby-install -V
cd ..
rm -rf ruby-install-*

# install ruby 3.1
# For best results this should match the version in capi-release
RUBY_VERSION="$(<~/workspace/capi-release/.ruby-version)"

ruby-install ${RUBY_VERSION}

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

echo "ruby-${RUBY_VERSION}" > ~/.ruby-version

# install bosh cli
wget https://github.com/cloudfoundry/bosh-cli/releases/download/v7.1.2/bosh-cli-7.1.2-linux-amd64
chmod +x bosh-cli-*-linux-amd64
sudo mv bosh-cli-*-linux-amd64 /usr/bin/bosh
bosh --version

# install credhub cli
mkdir -p /tmp/credhub
cd /tmp/credhub
wget https://github.com/cloudfoundry/credhub-cli/releases/download/2.9.10/credhub-linux-2.9.10.tgz
tar xf credhub*tgz
chmod +x credhub
sudo mv credhub /usr/bin
cd ..
rm -rf /tmp/credhub
credhub --version

# install om cli
wget https://github.com/pivotal-cf/om/releases/download/7.8.2/om-linux-amd64-7.8.2
chmod +x om*
sudo mv om* /usr/bin/om
om --version

# install bbl
wget https://github.com/cloudfoundry/bosh-bootloader/releases/download/v8.4.110/bbl-v8.4.110_linux_x86-64
chmod +x bbl*
sudo mv bbl* /usr/bin/bbl
bbl --version

# set up cf cli
cd ~/workspace
git clone https://github.com/cloudfoundry/cli.git
cd cli
git switch v8
PATH="$PATH:$HOME/workspace/cli/out:/usr/local/go/bin"
make build
cf --version

# set up git author
# must install git together from source as latest release v0.1.0-alpha.24 doesn't work on jammy
cd ~/workspace
git clone https://github.com/kejadlen/git-together.git
cd git-together
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
~/.cargo/bin/cargo build
sudo mv target/debug/git-together /usr/local/bin

# add git authors file and remove git together signoff
git config --global --add include.path ~/workspace/capi-workspace/assets/git-authors
cat >> ~/.$(basename $SHELL)rc <<EOF
export GIT_TOGETHER_NO_SIGNOFF=1
EOF

# figure out how to install git-author

# helper bash functions (deploy only new capi, claim bosh lite)  manually alias roundup_bosh_lites cause don't know if we want all of lib/misc.bash yet
cat >> ~/.$(basename $SHELL)rc <<EOF
source ~/workspace/capi-workspace/lib/pullify.bash
source ~/workspace/capi-workspace/lib/target-bosh.bash
source ~/workspace/capi-workspace/lib/claim-bosh-lite.bash
source ~/workspace/capi-workspace/lib/unclaim-bosh-lite.bash
PATH="$PATH:$HOME/workspace/capi-workspace/bin"
alias roundup_bosh_lites="print_env_info"
EOF

# git alias some of the above scripts use and we like
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.co checkout
