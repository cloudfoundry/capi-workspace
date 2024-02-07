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

user=pivotal
sudo gpasswd -a "${user}" docker

apt update
apt upgrade -y

# dependencies to run tests
apt install build-essential postgresql libpq-dev mysql-server libmysqlclient-dev zip unzip nodejs -y
apt-get install -yq apt-utils ca-certificates curl gpg
apt-get install -yq cowsay docker-buildx-plugin docker-ce docker-ce-cli docker-compose-plugin 

return
# ruby dependencies - this is to keep noninteractive mode on ruby-install command
apt install bison libffi-dev libgdbm-dev libncurses-dev libncurses5-dev libreadline-dev libyaml-dev m4 -y
# install dependencies for target_cf helper
apt install jq -y
# install dependencies for nvim telescope (fuzzy search)
apt install ripgrep -y
# install dependencies for capi-team-playbook which apparently needs a config directory
apt install lastpass-cli -y
# cypress
apt install libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb chromium-browser -y
# clean up anything not needed
apt autoremove -y

