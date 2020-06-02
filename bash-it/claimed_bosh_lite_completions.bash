#!/usr/bin/env bash

_claimed_bosh_lite_completions() {
	local env_pools="$HOME/workspace/capi-env-pool"
  COMPREPLY=($(compgen -W "$(ls ${env_pools}/bosh-lites/claimed)" "${COMP_WORDS[1]}"))
}

complete -F _claimed_bosh_lite_completions target_bosh
complete -F _claimed_bosh_lite_completions unclaim_bosh_lite
