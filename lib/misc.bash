# I believe most of these may be specific to one CAPI member
# Holding them all here until we can figure something out
#
# For example, what if we provided folks a "user/" folder like
# Luan's vim config, where they can put their custom bits
# -------------------------------------------------------------

# capi likes `alias g="git status"`, other teams like `alias g=git`, so do both:
alias g  >/dev/null 2>&1 && unalias g

function g() {
    case $# in
	0) git status ;;
	*) git "$@" ;;
    esac
}

# Misc aliases
alias cfu="seed_users"
alias where_my_bosh_lites_at="print_env_info"
alias bosh_lites="print_env_info"
alias yamlvim="vim -c 'set syntax=yaml'"

function cf_auth_config() {
	cf api "$(jq -r .api cats_integration_config.json)" --skip-ssl-validation
	cf auth admin "$(jq -r .admin_password cats_integration_config.json)"
}

function int() {
	export CF_INT_API=https://api.$BOSH_LITE_DOMAIN

	credhub login --skip-tls-validation
	export CF_INT_PASSWORD=$(credhub get --name '/bosh-lite/cf/cf_admin_password' --output-json | jq -r '.value')
}

function let_me_pull() {
    local ssh_url="$(git remote get-url --push origin)"
    local https_url="$(echo $ssh_url | awk '{gsub(/git@github.com:/,"https://github.com/")}1')"
    if ! echo ${ssh_url} | grep 'git@' > /dev/null; then
	echo 'push url doesnt seem to be ssh... exiting without changing anything'
	return
    fi

    echo 'setting fetch to https and push to ssh'
    git remote set-url origin "${https_url}"
    git remote set-url origin --push "${ssh_url}"
    git remote -v
    echo 'success!'
}