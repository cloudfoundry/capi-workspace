#!/bin/bash
set -xe

function clone {
	local repo=$1
	local destination=$2

	if [ ! -d $destination ]; then
		echo "Cloning $destination"
                git clone $repo $destination	
	else
		echo "$destination already present, skipping"
	fi
}



curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
# dependencies to run tests
sudo DEBIAN_FRONTEND=noninteractive apt install build-essential postgresql libpq-dev mysql-server libmysqlclient-dev zip unzip nodejs -y
# ruby dependencies - this is to keep noninteractive mode on ruby-install command
sudo DEBIAN_FRONTEND=noninteractive apt install bison libffi-dev libgdbm-dev libncurses-dev libncurses5-dev libreadline-dev libyaml-dev m4 -y
# install dependencies for target_cf helper
sudo DEBIAN_FRONTEND=noninteractive apt install jq -y
# install dependencies for nvim telescope (fuzzy search)
sudo DEBIAN_FRONTEND=noninteractive apt install ripgrep -y
# install dependencies for capi-team-playbook which apparently needs a config directory
sudo DEBIAN_FRONTEND=noninteractive apt install lastpass-cli -y
# cypress
sudo DEBIAN_FRONTEND=noninteractive apt install libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb chromium-browser -y
mkdir -p ~/.config
# clean up anything not needed
sudo apt autoremove -y

# add github.com to list of known hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

# Install kubectl
sudo curl -L -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x /usr/local/bin/kubectl

# make workspace
mkdir -p ~/workspace

# clone things into workspace
# Need to clone with https because we don't have a Github account with SSH key available at this point
cd ~/workspace
git config --global url."git@github.com:".pushInsteadOf https://github.com/
git config --global core.editor "nvim"

if [ ! -d ~/workspace/capi-release ]; then
	git clone https://github.com/cloudfoundry/capi-release --branch develop
fi

pushd capi-release
  ./scripts/update
popd

clone https://github.com/cloudfoundry/capi-ci ~/workspace/capi-ci
clone https://github.com/cloudfoundry/cf-acceptance-tests ~/workspace/cf-acceptance-tests
clone https://github.com/cloudfoundry/capi-bara-tests ~/workspace/capi-bara-tests
clone https://github.com/cloudfoundry/sync-integration-tests ~/workspace/sync-integration-tests
clone https://github.com/cloudfoundry/capi-dockerfiles ~/workspace/capi-dockerfiles
clone https://github.com/cloudfoundry/stack-auditor ~/workspace/stack-auditor


# set correct branch for capi env pools
pushd capi-env-pool
  git switch main
popd

# tmux setup with luan
clone https://github.com/luan/tmuxfiles.git ~/workspace/tmuxfiles
pushd ~/workspace/tmuxfiles
./install
popd

# install nvim
if ! command -v nvim &> /dev/null; then
  wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage --appimage-extract
  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  rm nvim.appimage
  nvim -v
fi
# up/down arrow search history
if [ ! -L ~/.inputrc ]; then
  ln -s ~/workspace/capi-workspace/.inputrc ~/.inputrc
fi

# nvim plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.config/nvim
if [ ! -L ~/.config/nvim/init.vim ]; then
  ln -s ~/workspace/capi-workspace/init.vim ~/.config/nvim/init.vim
fi

# setup mysql
sudo service mysql start
sudo service mysql status # might need loop here depending how long status takes
set +e
mysql -u root --password=password -e "show databases;"
MYSQL_RETURN=$?
set -e
if [ $MYSQL_RETURN != 0 ]; then
  sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
fi

# setup postgres
sudo sed -i 's/peer/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
sudo sed -i 's/scram-sha-256/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
sudo sed -i 's/md5/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
sudo service postgresql restart

# install golang to get latest
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
# set go and cf cli and ~/go/bin on path
cat >> ~/.$(basename $SHELL)rc <<EOF
PATH="$PATH:$HOME/workspace/cli/out:/usr/local/go/bin:$HOME/go/bin"
EOF
rm go1.20.4.linux-amd64.tar.gz

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

ruby-install ${RUBY_VERSION} --no-reinstall

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

# install git-duet
wget https://github.com/git-duet/git-duet/releases/download/0.9.0/linux_amd64.tar.gz
sudo tar -xvf linux_amd64.tar.gz -C /usr/local/bin/

# install dir-env
sudo apt install direnv

# install fly if not already installed
if ! which fly > /dev/null ; then
	destination=/usr/local/bin/fly
	sudo wget "https://ci.capi.land/api/v1/cli?arch=amd64&platform=linux" -O $destination
	sudo chmod +x $destination
fi

# set up cf cli
clone https://github.com/cloudfoundry/cli.git ~/workspace/cli
cd ~/workspace/cli
git switch v8
PATH="$PATH:$HOME/workspace/cli/out:/usr/local/go/bin:$HOME/go/bin"
make build
cf --version

# install gopls for nvim
go install golang.org/x/tools/gopls@latest

# add git authors file
if [ ! -L ~/.git-authors ]; then
  ln -s ~/workspace/capi-workspace/assets/git-authors ~/.git-authors
fi

# environment variables and helper bash functions (deploy only new capi, claim bosh lite)  manually alias roundup_bosh_lites cause don't know if we want all of lib/misc.bash yet
cat >> ~/.$(basename $SHELL)rc <<EOF
# use co-authored-by trailer in git-duet
export GIT_DUET_CO_AUTHORED_BY=1
export GIT_DUET_SET_GIT_USER_CONFIG=true

export TERM=xterm-256color

source ~/workspace/capi-workspace/lib/pullify.bash
source ~/workspace/capi-workspace/lib/target-bosh.bash
source ~/workspace/capi-workspace/lib/claim-bosh-lite.bash
source ~/workspace/capi-workspace/lib/unclaim-bosh-lite.bash
PATH="$PATH:$HOME/workspace/capi-workspace/bin"
alias roundup_bosh_lites="print_env_info"
alias gst="git status"
EOF

# prepare cloudcontroller_ng for running tests
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
pushd ~/workspace/capi-release/src/cloud_controller_ng
  bundle install
  DB=mysql bundle exec rake db:recreate
  DB=postgres bundle exec rake db:recreate
popd

# git alias some of the above scripts use and we like
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.co checkout
