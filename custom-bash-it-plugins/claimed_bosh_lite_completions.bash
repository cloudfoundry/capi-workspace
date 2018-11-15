#!/usr/bin/env bash

_claimed_bosh_lite_completions() {
  COMPREPLY=($(compgen -W "$(ls ~/workspace/capi-env-pool/bosh-lites/claimed)" "${COMP_WORDS[1]}"))
}

complete -F _claimed_bosh_lite_completions target_bosh
complete -F _claimed_bosh_lite_completions unclaim_bosh_lite