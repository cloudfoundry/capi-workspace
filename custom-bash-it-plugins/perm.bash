#!/bin/bash

PERM_RELEASE_NAME="perm"

WORKSPACE="${HOME}/workspace"
PERM_RELEASE_REPO="${WORKSPACE}/perm-release"
CF_DEPLOYMENT_REPO="${WORKSPACE}/cf-deployment"
PERM_CI_REPO="${WORKSPACE}/perm-ci"
CAPI_CI_REPO="${WORKSPACE}/capi-ci"

function add_perm_to_bosh_lite() (
  set -eu

  bosh -n \
    deploy ~/workspace/cf-deployment/cf-deployment.yml \
    -v system_domain="$BOSH_LITE_DOMAIN" \
    -v perm_version="latest" \
    -o "${CF_DEPLOYMENT_REPO}/operations/workaround/undo-metron-add-on.yml" \
    -o "${CAPI_CI_REPO}/cf-deployment-operations/skip-cert-verify.yml" \
    -o "${CAPI_CI_REPO}/cf-deployment-operations/use-latest-stemcell.yml" \
    -o "${CF_DEPLOYMENT_REPO}/operations/experimental/enable-bpm.yml" \
    -o "${CF_DEPLOYMENT_REPO}/operations/experimental/skip-consul-cell-registrations.yml" \
    -o "${CF_DEPLOYMENT_REPO}/operations/experimental/skip-consul-locks.yml" \
    -o "${CF_DEPLOYMENT_REPO}/operations/experimental/use-bosh-dns.yml" \
    -o "${CF_DEPLOYMENT_REPO}/operations/experimental/disable-consul.yml" \
    -o "${PERM_CI_REPO}/cf-deployment-operations/workaround/reenable-consul-stub.yml" \
    -o "${CF_DEPLOYMENT_REPO}/operations/bosh-lite.yml" \
    -o "${PERM_CI_REPO}/cf-deployment-operations/workaround/disable-consul-bosh-lite.yml" \
    -o "${CF_DEPLOYMENT_REPO}/operations/use-compiled-releases.yml" \
    -o "${PERM_CI_REPO}/cf-deployment-operations/add-perm.yml" \
    -o "${CAPI_CI_REPO}/cf-deployment-operations/use-latest-capi.yml" \
    "$@"
)

function create_perm_release() (
  set -eu

  pushd "$PERM_RELEASE_REPO" > /dev/null
    git submodule sync --recursive && git submodule update --init --recursive
  popd

  RELEASE_NAME="$PERM_RELEASE_NAME" RELEASE_DIR="$PERM_RELEASE_REPO" create_release
)

function upload_perm_release() (
  set -eu

  RELEASE_NAME="$PERM_RELEASE_NAME" RELEASE_DIR="$PERM_RELEASE_REPO" upload_release
)

function create_and_upload_perm_release() (
  set -eu

  create_perm_release
  upload_perm_release
)

function create_release() (
  : "${RELEASE_NAME:?"Need to set RELEASE_NAME"}"
  : "${RELEASE_DIR:?"Need to set RELEASE_DIR"}"

  echo "Creating release ${RELEASE_NAME}"

  bosh --sha2 cr \
    --force \
    --name "$RELEASE_NAME" \
    --dir "$RELEASE_DIR"

  echo "Created release ${RELEASE_NAME}"
)

function upload_release() (
  set -eu

  : "${BOSH_ENVIRONMENT:?"Need to set BOSH_ENVIRONMENT"}"
  : "${RELEASE_DIR:?"Need to set RELEASE_DIR"}"
  : "${RELEASE_NAME:?"Need to set RELEASE_NAME"}"

  echo "Uploading release ${RELEASE_NAME}"

  bosh ur --dir "$RELEASE_DIR"

  echo "Uploaded release ${RELEASE_NAME}"
)
