# I believe most of these may be specific to one CAPI member
# Holding them all here until we can figure something out
#
# For example, what if we provided folks a "user/" folder like
# Luan's vim config, where they can put their custom bits
# -------------------------------------------------------------

alias cfu="seed_users"
alias roundup_bosh_lites="print_env_info"
alias bosh_lites="print_env_info"
alias yamlvim="vim -c 'set syntax=yaml'"

function cf_auth_config() {
	if [ -f cats_integration_config.json ]; then
	    CONFIG=$(pwd)/cats_integration_config.json
	elif [ -f integration_config.json ]; then
	    CONFIG=$(pwd)/integration_config.json
	fi
	cf api "$(jq -r .api ${CONFIG})" --skip-ssl-validation
	cf auth admin "$(jq -r .admin_password ${CONFIG})"
}

function int() {
	export CF_INT_API=https://api.$BOSH_LITE_DOMAIN
	export CF_INT_PASSWORD=$(credhub get --name '/bosh-lite/cf/cf_admin_password' --output-json | jq -r '.value')
}
