#!/usr/bin/env bash

target_bosh() {
  # tput setaf 1 = red
  # tput setaf 2 = green
  # tput setaf 9 = reset color

  local env_pool="$HOME/workspace/capi-env-pool"
  local claimed_dir="$env_pool/bosh-lites/claimed"

  pushd ${claimed_dir} >/dev/null
    git pull
  popd >/dev/null

  if [ -z "$1" ]; then
    echo "$(tput setaf 1)Usage: target_bosh <environment>. Valid environments are:$(tput setaf 9)"
    ls ${claimed_dir}
  else
    env_file=${claimed_dir}/${1}

    if [ -f "$env_file" ]; then
      source "$env_file"
      env_ssh_key_path="${env_pool}/${1}/bosh.pem"
      env_integration_config_path="${env_pool}/${1}/integration_config.json"

      if [ ! -f "${env_ssh_key_path}" ]; then
        echo "${BOSH_GW_PRIVATE_KEY_CONTENTS}" > "${env_ssh_key_path}"
        chmod 0600 "${env_ssh_key_path}"
      fi

      if [ ! -f "${env_integration_config_path}" ]; then
        echo "writing ${1} a capi-specific integration_config.json..."
        generate_integration_config > "${env_integration_config_path}"
      fi

      echo "$(tput setaf 2)Success!$(tput setaf 9)"

      export BOSH_GW_PRIVATE_KEY="${env_ssh_key_path}"
      export BOSH_ALL_PROXY=ssh+socks5://${BOSH_GW_USER}@${BOSH_ENVIRONMENT}:22?private-key=${BOSH_GW_PRIVATE_KEY}
      export CONFIG="${env_integration_config_path}"
    else
      echo "$(tput setaf 1)Environment '${1}' does not exist. Valid environments are:$(tput setaf 9)"
      ls ${claimed_dir}
    fi
  fi
}

export -f target_bosh
