#!/usr/bin/env bash

deploy_only_new_capi() {
  capi_release_dir=~/workspace/capi-release
  manifest_file=$(mktemp)

  bosh manifest > $manifest_file

  bosh deploy $manifest_file \
    -o ~/workspace/capi-ci/cf-deployment-operations/use-created-capi.yml \
    -v capi_release_dir=$capi_release_dir \
    -n
}

export -f deploy_only_new_capi