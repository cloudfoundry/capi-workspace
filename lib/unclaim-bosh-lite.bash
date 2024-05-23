function unclaim_bosh_lite() {
  git_user=$(git config --get user.name)
  if [ -z "$git_user" ]; then
    echo "Please set your git user before running this!"
    return
  fi

  local env_pool="$HOME/workspace/capi-env-pool"

  # ensures we don't remove the current working directory
  if [[ "$PWD" == *capi-env-pool* ]]; then
    cd "$HOME/workspace/capi-env-pool"
  fi
  if [[ "$PWD" == *cli-pools* ]]; then
    cd "$HOME/workspace/cli-pools"
  fi
  (
    set -e
    cd "$env_pool"

    working_pool="bosh-lites"
    broken_pool="broken-bosh-lites"

    if [ $# -eq 0 ]; then
      echo "Usage: $0 env_name"
      return 1
    fi

    echo "Refreshing bosh lite pool state..."
    git pull -n -r --quiet --no-verify

    function mark_broken {
      env=$1
      file="$(find "${working_pool}" -name "${env}")"

      if [[ "$file" == "" ]]; then
        echo "$env does not exist in ${working_pool}"
        return 1
      fi

      printf "Hit enter to release ${env} "
      read -r

      git mv "${file}" "${broken_pool}/unclaimed/"
      if [ -d "${env}" ]; then
        git rm -rf "${env}" && \rm -rf "${env}"
      fi

      git ci --quiet -m"releasing $env on $( hostname )" --no-verify
      echo "Pushing the release commit to $( basename "$PWD" )..."
      git push --quiet
    }

    for env in "$@"; do
      mark_broken "${env}"
    done
  )

  unset BOSH_CA_CERT BOSH_CLIENT BOSH_CLIENT_SECRET BOSH_ENVIRONMENT \
    BOSH_DEPLOYMENT BOSH_GW_USER BOSH_GW_HOST BOSH_LITE_DOMAIN \
    BOSH_GW_PRIVATE_KEY_CONTENTS BOSH_GW_PRIVATE_KEY CONFIG BOSH_ALL_PROXY \
    CREDHUB_SERVER CREDHUB_CLIENT CREDHUB_SECRET

  echo "Done!"
}

export -f unclaim_bosh_lite
