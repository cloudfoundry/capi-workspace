#!/bin/bash

if ! which consul > /dev/null ; then
  echo "Installing consul for testing with CC bridge"
  consul_path=$GOPATH/src/github.com/hashicorp/consul

  git clone https://github.com/hashicorp/consul.git "${consul_path}"

  pushd $consul_path
    git co "v0.7.0"
	  make
	  mv bin/consul /usr/local/bin/consul
  popd
fi
