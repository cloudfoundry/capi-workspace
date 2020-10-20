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

GO_UTILS=(
  github.com/rakyll/hey
  github.com/maxbrunsfeld/counterfeiter
  github.com/onsi/ginkgo/ginkgo
  github.com/onsi/gomega
  github.com/XenoPhex/i18n4go/i18n4go
  github.com/sgreben/yeetgif/cmd/gif
)

echo "Running $(go version)"
for gopkg in "${GO_UTILS[@]}"; do
  echo "Getting/Updating $gopkg"
  GOPATH=$HOME/go go get -u $gopkg
done

if ! which golangci-lint 2>&1 > /dev/null ; then
    curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh |
	    sh -s -- -b $(go env GOPATH)/bin 
fi
