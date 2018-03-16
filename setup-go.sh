#!/bin/bash
set -e

echo "Creating go/src and workspace..."
go_src=${HOME}/go/src
if [ ! -e ${go_src} ]; then
  mkdir -pv ${HOME}/go/src
fi

if [ -L ${go_src} ]; then
  echo "${go_src} exists, but is a symbolic link"
fi

echo "Install ginkgo..."
GOPATH="${HOME}/go" go get -u github.com/onsi/ginkgo/ginkgo

echo "Install gomega..."
GOPATH="${HOME}/go" go get -u github.com/onsi/gomega

echo "Installing hey..."
GOPATH="${HOME}/go" go get -u github.com/rakyll/hey
