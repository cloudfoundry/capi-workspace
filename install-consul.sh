#!/bin/bash

echo "Installing Consul"

set +e
consul --version
consul_status=$?
set -e

if [ ${consul_status} -ne 0 ]; then
  wget https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_darwin_amd64.zip -O /tmp/consul.zip && \
  unzip /tmp/consul.zip -d /usr/local/bin
  rm /tmp/consul.zip
fi
