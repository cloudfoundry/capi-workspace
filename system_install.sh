#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# install node 20 from https://github.com/nodesource/distributions#installation-instructions
apt update
apt install -y ca-certificates curl gnupg

mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
# Add docker apt repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(grep VERSION_CODENAME /etc/os-release | cut -d '=' -f 2) stable" | tee /etc/apt/sources.list.d/docker.list
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# add github cli apt repo
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list

user=pivotal
sudo gpasswd -a "${user}" docker

apt update
apt upgrade -y

# dependencies to run tests
apt install build-essential postgresql libpq-dev mysql-server libmysqlclient-dev zip unzip nodejs -y
apt-get install -yq apt-utils ca-certificates curl gpg
apt-get install -yq cowsay docker-buildx-plugin docker-ce docker-ce-cli docker-compose-plugin 

# ruby dependencies - this is to keep noninteractive mode on ruby-install command
apt install bison libffi-dev libgdbm-dev libncurses-dev libncurses5-dev libreadline-dev libyaml-dev m4 -y
# install dependencies for capi-team-playbook which apparently needs a config directory
apt install lastpass-cli -y
# cypress
apt install libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb chromium-browser -y
# clean up anything not needed
apt autoremove -y

install_asdf() {
    which asdf && return

    remote=https://github.com/asdf-vm/asdf.git
    branch=$(git ls-remote --tags --exit-code --refs "$remote" \
      | sed -E 's/^[[:xdigit:]]+[[:space:]]+refs\/tags\/(.+)/\1/g' \
      | sort --version-sort | tail -n1)

    git clone ${remote:?} ~/.asdf \
      --branch "${branch:?}" \
      --depth 1 \
      --shallow-submodules

     grep --quiet asdf.sh $HOME/.bashrc || cat <<EOC >> "$HOME/.bashrc"
source "$HOME/.asdf/asdf.sh"
source "$HOME/.asdf/completions/asdf.bash"
EOC

    source "$HOME/.asdf/asdf.sh"
    asdf update --all
}

with_asdf_get(){
    package_name=${1:?Need package name}
    package_version=${2:-latest}

    asdf plugin add "$package_name"
    asdf install    "$package_name" "$package_version"
    asdf  global    "$package_name" "$package_version"
}

# full list of asdf plugins https://github.com/asdf-vm/asdf-plugins/tree/master/plugins

with_asdf_get fd          latest
with_asdf_get fzf         latest
with_asdf_get github-cli  latest
with_asdf_get jless       0.8.0
with_asdf_get jq          latest
with_asdf_get ripgrep     latest
with_asdf_get yq          latest
with_asdf_get ytt         latest