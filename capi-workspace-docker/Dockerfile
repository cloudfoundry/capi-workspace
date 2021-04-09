FROM ruby:2.7-buster


RUN apt-get update

RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

RUN apt-get install -y \ 
     git \
     wget \
     curl \
     apt-utils \
     tmux \
     ruby \
     default-mysql-server \
     ruby-dev \
     postgresql-contrib \
     postgresql \
     libpq5 \
     libpq-dev \
     ripgrep \
     fd-find \
     nodejs \
     npm \
     sudo \
     neovim \
     lastpass-cli \
     software-properties-common \
     apt-transport-https \ 
     openssh-server


#Luan's nvim deps
RUN apt-get install -y \
     golang

RUN gem install bundler
RUN service mysql start && \
    echo 'mysql-server mysql-server/root_password password password' | debconf-set-selections && \ 
    echo 'mysql-server mysql-server/root_password_again password password' | debconf-set-selections

#Install Credhub CLI
RUN mkdir /tmp/credhub -p && \
    cd /tmp/credhub && \
    wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.9.0/credhub-linux-2.9.0.tgz && \
    tar xf credhub*tgz && \
    chmod +x credhub && \
    mv credhub /usr/bin && \
    cd / && \
    rm -rf /tmp/credhub

RUN service ssh restart

#Install Bosh CLI
RUN wget https://github.com/cloudfoundry/bosh-cli/releases/download/v6.4.1/bosh-cli-6.4.1-linux-amd64 && \
    mv bosh-cli-6.4.1-linux-amd64 /usr/bin/bosh && \
    chmod +x /usr/bin/bosh

# Capi user section
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN useradd -rm -d /home/capi -s /bin/bash -g root -G sudo -u 1001 capi -p capi
USER capi
WORKDIR /home/capi

RUN mkdir /home/capi/tmp
ENV TMUX_TMPDIR=/home/capi/tmp

RUN git clone https://github.com/luan/nvim ~/.config/nvim

RUN nvim +UpdateRemotePlugins +qall && \
    nvim +GoInstallBinaries +qall

# The command to update plugins keeps exiting 0 on docker build, even though it still installs the plugins, swallowing error for now
RUN nvim +'PlugInstall --sync' +qa; exit 0

RUN set -ex && \
    bundle config path ~/.gem/ruby && \
    mkdir ~/workspace && \
    cd workspace && \
    git clone https://github.com/cloudfoundry/capi-release.git && \
    cd capi-release && \
    ./scripts/update

RUN cd ~/workspace/capi-release/src/cloud_controller_ng && \
    bundle install

CMD sleep infinity
