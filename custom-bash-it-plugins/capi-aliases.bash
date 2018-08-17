#FASD
alias v='fasd -e vim'

alias b='bundle exec'
alias bake='bundle exec rake'

# Git aliases
alias gd='git diff'
alias gdc='git diff --cached'
alias g='git status'

# Misc aliases
alias gi='gem install'

# dev org/space setup
alias lite='(target_cf && cf rp test)'
alias relite='(target_cf && cf rp retest)'

# ci
alias watch_latest_cc_units='fly -t capi watch -j capi/cc-unit-tests'

alias create_and_deploy='create_and_upload && ~/workspace/capi-release/scripts/deploy'
alias create_and_force_deploy='create_and_upload && ~/workspace/capi-release/scripts/deploy -n'
