#!/bin/bash
#vi:tabstop=2 shiftwidth=2 expandtab
set -xe

function clone {
  local repo=$1
  local destination=$2
  local branch=$3

  if [ ! -d "$destination" ]; then
    echo "Cloning $destination"

    if [[ -n "$branch" ]]; then
      git clone --branch "$branch" "$repo" "$destination"
    else
      git clone "$repo" "$destination"
    fi
  else
    echo "$destination already present, updating"
    pushd "$destination"
      git pull || echo "messy..."
    popd
  fi
}

curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
# dependencies to run tests
sudo DEBIAN_FRONTEND=noninteractive apt install build-essential postgresql libpq-dev mysql-server libmysqlclient-dev zip unzip -y
# ruby dependencies - this is to keep noninteractive mode on ruby-install command
sudo DEBIAN_FRONTEND=noninteractive apt install bison libffi-dev libgdbm-dev libncurses-dev libncurses5-dev libreadline-dev libyaml-dev m4 -y
# install dependencies for target_cf helper
# install dependencies for nvim telescope (fuzzy search)
# install dependencies for capi-team-playbook which apparently needs a config directory
sudo DEBIAN_FRONTEND=noninteractive apt install lastpass-cli -y
# cypress
sudo DEBIAN_FRONTEND=noninteractive apt install libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb chromium-browser -y
mkdir -p "$HOME/.config"
# clean up anything not needed
sudo apt autoremove -y

# add github.com to list of known hosts
ssh-keyscan github.com >> "$HOME/.ssh/known_hosts"

# make workspace
mkdir -p "$HOME/workspace"

# clone things into workspace
# Need to clone with https because we don't have a Github account with SSH key available at this point
cd "$HOME/workspace"
git config --global url."git@github.com:".pushInsteadOf https://github.com/
git config --global core.editor "nvim"

clone https://github.com/cloudfoundry/capi-release "$HOME/workspace/capi-release" develop

pushd capi-release
  ./scripts/update
popd

clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" v0.12.0
source "$HOME/.asdf/asdf.sh"

clone https://github.com/cloudfoundry/capi-ci "$HOME/workspace/capi-ci"
clone https://github.com/cloudfoundry/cf-acceptance-tests "$HOME/workspace/cf-acceptance-tests"
clone https://github.com/cloudfoundry/capi-bara-tests "$HOME/workspace/capi-bara-tests"
clone https://github.com/cloudfoundry/sync-integration-tests "$HOME/workspace/sync-integration-tests"
clone https://github.com/cloudfoundry/capi-dockerfiles "$HOME/workspace/capi-dockerfiles"
clone https://github.com/cloudfoundry/stack-auditor "$HOME/workspace/stack-auditor"


# set correct branch for capi env pools
pushd capi-env-pool
  git switch main
popd

# tmux setup with luan
clone https://github.com/luan/tmuxfiles.git "$HOME/workspace/tmuxfiles"
pushd "$HOME/workspace/tmuxfiles"
./install
popd

cat >> "$HOME/.$(basename $SHELL)rc" <<EOF
  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
EOF

cat >> "$HOME/.asdfrc" <<EOF
legacy_version_file = yes
EOF

# For best results this should match the version in capi-release
RUBY_VERSION="$(<$HOME/workspace/capi-release/.ruby-version)"
RUBY_CAPI_LTS_VERSION=3.0.6

asdf plugin add ruby || true
asdf install ruby latest
asdf install ruby "${RUBY_VERSION}"
asdf install ruby "${RUBY_CAPI_LTS_VERSION}"
asdf global ruby latest

function asdf_install_and_make_global {
  local name=$1
  local version=${2:-latest}

  asdf plugin add "${name:?}" || true
  asdf install "${name:?}" "${version:?}"
  asdf global "${name:?}" "${version:?}"
}

asdf plugin-add direnv || true
asdf direnv setup --shell bash --version latest

asdf_install_and_make_global nodejs
asdf_install_and_make_global golang
asdf_install_and_make_global bosh
asdf_install_and_make_global credhub
asdf_install_and_make_global fly
asdf_install_and_make_global om
asdf_install_and_make_global uaa-cli
asdf_install_and_make_global ytt
asdf_install_and_make_global pivnet
asdf_install_and_make_global jq
asdf_install_and_make_global yq
asdf_install_and_make_global fzf
asdf_install_and_make_global fd
asdf_install_and_make_global ripgrep
asdf_install_and_make_global kubectl
asdf_install_and_make_global k9s
asdf_install_and_make_global cf
asdf_install_and_make_global github-cli
asdf_install_and_make_global neovim

# nvim plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p "$HOME/.config/nvim"
if [ ! -L "$HOME/.config/nvim/init.vim" ]; then
  ln -s "$HOME/workspace/capi-workspace/init.vim" "$HOME/.config/nvim/init.vim"
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


# install bbl
wget https://github.com/cloudfoundry/bosh-bootloader/releases/download/v8.4.110/bbl-v8.4.110_linux_x86-64
chmod +x bbl*
sudo mv bbl* /usr/bin/bbl
bbl --version

# install git-duet
wget https://github.com/git-duet/git-duet/releases/download/0.9.0/linux_amd64.tar.gz
sudo tar -xvf linux_amd64.tar.gz -C /usr/local/bin/

# set up cf cli
clone https://github.com/cloudfoundry/cli.git "$HOME/workspace/cli"
cd "$HOME/workspace/cli"
git switch v8
PATH="$PATH:$HOME/workspace/cli/out:/usr/local/go/bin:$HOME/go/bin"
make build
cf --version

# install gopls for nvim
go install golang.org/x/tools/gopls@latest

# add git authors file
if [ ! -L "$HOME/.git-authors" ]; then
  ln -s "$HOME/workspace/capi-workspace/assets/git-authors" "$HOME/.git-authors"
fi

# environment variables and helper bash functions (deploy only new capi, claim bosh lite)  manually alias roundup_bosh_lites cause don't know if we want all of lib/misc.bash yet
cat >> "$HOME/.$(basename $SHELL)rc" <<EOF
# use co-authored-by trailer in git-duet
export GIT_DUET_CO_AUTHORED_BY=1
export GIT_DUET_SET_GIT_USER_CONFIG=true

export TERM=xterm-256color

source "$HOME/workspace/capi-workspace/lib/pullify.bash"
source "$HOME/workspace/capi-workspace/lib/target-bosh.bash"
source "$HOME/workspace/capi-workspace/lib/claim-bosh-lite.bash"
source "$HOME/workspace/capi-workspace/lib/unclaim-bosh-lite.bash"
PATH="$PATH:$HOME/workspace/capi-workspace/bin"
alias roundup_bosh_lites="print_env_info"
alias gst="git status"
EOF

# prepare cloudcontroller_ng for running tests
pushd "$HOME/workspace/capi-release/src/cloud_controller_ng"
  asdf install
  bundle install
  DB=mysql bundle exec rake db:recreate
  DB=postgres bundle exec rake db:recreate
popd

# git alias some of the above scripts use and we like
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.co checkout
