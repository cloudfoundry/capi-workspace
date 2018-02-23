alias resprout='(cd ~/workspace/sprout-capi && git pull && chruby-exec system -- bundle exec soloist)'

# CATs
alias cats='(cd ~/workspace/cf-release/src/github.com/cloudfoundry/cf-acceptance-tests && CONFIG=$PWD/integration_config.json bin/test --nodes=3)'

# Deploying (bosh2 + cf-deployment)
alias upload_capi_release='~/workspace/capi-release/scripts/create-and-upload'
alias create_and_deploy='upload_capi_release && ~/workspace/capi-release/scripts/deploy'
alias create_and_force_deploy='upload_capi_release && ~/workspace/capi-release/scripts/deploy -n'
alias bootstrap_cf='~/workspace/capi-release/scripts/bootstrap-cf'
alias target_cf='~/workspace/capi-release/scripts/target-cf'
alias target_uaa='~/workspace/capi-release/scripts/target-uaa'
alias deploy='create_and_force_deploy'
alias print_env_info='pushd ~/workspace/capi-env-pool > /dev/null && git pull > /dev/null &&  ~/workspace/capi-ci/ci/bosh-lite/src/print_env_info && popd > /dev/null'

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
