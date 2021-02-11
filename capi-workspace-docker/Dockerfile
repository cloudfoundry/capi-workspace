FROM ubuntu:focal


RUN apt-get update

RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

RUN apt-get install -y \ 
     git \
     wget \
     curl \
     apt-utils \
     tmux \
     ruby \
     mysql-server \
     libmysqlclient-dev \
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
     lastpass-cli


#Luan's nvim deps
RUN apt-get install -y \
     golang

RUN gem install bundler
RUN service mysql start && \
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"

#Install Credhub CLI
RUN mkdir tmp -p && \
    cd tmp && \
    wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.9.0/credhub-linux-2.9.0.tgz && \
    tar xf credhub*tgz && \
    chmod +x credhub && \
    mv credhub /usr/bin && \
    cd .. && \
    rm -rf tmp

#Install Bosh CLI

RUN wget https://github.com/cloudfoundry/bosh-cli/releases/download/v6.4.1/bosh-cli-6.4.1-linux-amd64 && \
    mv bosh-cli-6.4.1-linux-amd64 /usr/bin/bosh && \
    chmod +x /usr/bin/bosh
RUN useradd -rm -d /home/capi -s /bin/bash -g root -G sudo -u 1001 capi
USER capi
WORKDIR /home/capi

RUN git clone https://github.com/luan/nvim ~/.config/nvim

RUN nvim +UpdateRemotePlugins +qall && \
    nvim +GoInstallBinaries +qall

# The command to update plugins keeps exiting 0 on docker build, even though it still installs the plugins, swallowing error for now
RUN nvim +'PlugInstall --sync' +qa; exit 0

RUN mkdir ~/workspace
RUN git clone

CMD sleep infinity:
