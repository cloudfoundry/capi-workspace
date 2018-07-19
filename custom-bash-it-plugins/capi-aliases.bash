# CATs
alias cats='(cd ~/go/src/github.com/cloudfoundry/cf-acceptance-tests && CONFIG=$PWD/integration_config.json bin/test --nodes=3)'

alias print_env_info='pushd ~/workspace/capi-env-pool > /dev/null; git pull > /dev/null &&  ~/workspace/capi-ci/ci/bosh-lite/src/print_env_info; popd > /dev/null'

# PSQL
alias psql_bosh_lite='~/workspace/capi-release/scripts/psql-bosh-lite'
alias mysql_bosh_lite='~/workspace/capi-release/scripts/mysql-bosh-lite'

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
