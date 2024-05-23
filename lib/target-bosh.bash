#!/usr/bin/env bash

target_bosh() {
  local env_pool="$HOME/workspace/capi-env-pool"
  local claimed_dir="$env_pool/bosh-lites/claimed"

  echo "❯ Refreshing bosh lite pool state..."
  pushd ${claimed_dir} >/dev/null
    git pull | sed 's/^/\t/'
  popd >/dev/null

  if [ -z "$1" ]; then
    echo "$(tput setaf 1)Usage: target_bosh <environment>. Valid environments are:$(tput setaf 9)"
    ls ${claimed_dir}
  else
    env_file=${claimed_dir}/${1}

    if [ -f "$env_file" ]; then
      echo "❯ Sourcing ${env_file} to set bosh environment variables..."
      source "$env_file"

      env_integration_config_path="${env_pool}/${1}/integration_config.json"
      if [ ! -f "${env_integration_config_path}" ]; then
        echo "❯ Writing a capi-specific integration_config.json..."
        generate_integration_config > "${env_integration_config_path}"
        echo -e "\tGenerated ${env_integration_config_path}. Enjoy!"
      fi

      env_ssh_key_path="${env_pool}/${1}/bosh.pem"
      if [ ! -f "${env_ssh_key_path}" ]; then
        echo "❯ Writing a bosh gateway ssh key..."
        echo "${BOSH_GW_PRIVATE_KEY_CONTENTS}" > "${env_ssh_key_path}"
        chmod 0600 "${env_ssh_key_path}"
        echo -e "\tGenerated ${env_ssh_key_path}. Enjoy!"
      fi

      echo "❯ Setting BOSH_GW_PRIVATE_KEY, BOSH_ALL_PROXY, and CONFIG environment variables..."
      export BOSH_GW_PRIVATE_KEY="${env_ssh_key_path}"
      export BOSH_ALL_PROXY=ssh+socks5://${BOSH_GW_USER}@${BOSH_ENVIRONMENT}:22?private-key=${BOSH_GW_PRIVATE_KEY}
      export CONFIG="${env_integration_config_path}"

      echo "$(tput setaf 2)Success!$(tput setaf 9)"
    else
      echo "$(tput setaf 1)Environment '${1}' does not exist. Valid environments are:$(tput setaf 9)"
      ls ${claimed_dir}
    fi
  fi
}

export -f target_bosh
