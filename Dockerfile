FROM ubuntu:focal

# Some things, like brew, refuse to be installed if run as root
RUN useradd --system -s /sbin/nologin capi
USER capi

RUN  apt-get update && \
     apt-get install -y \ 
     git \
     wget \
     curl \
     apt-utils \
     sudo

RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

RUN mkdir -p ~/workspace && \
    cd ~/workspace && \
    git clone https://github.com/cloudfoundry/capi-workspace.git && \
    cd capi-workspace && \ 
    git checkout dockerfile && \
    ./install.sh

