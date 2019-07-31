#FASD
alias v='fasd -e vim'
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

alias b='bundle exec'
alias bake='echo "bundling..." && bundle install --quiet && echo "done bundling" && bundle exec rake'
alias fastbake='echo "bundling..." && bundle install --quiet && echo "done bundling" && DB=postgres bundle exec rake'
alias slowbake='echo "bundling..." && bundle install --quiet && echo "done bundling" && DB=mysql bundle exec rake'

# Git aliases
alias gd='git diff'
alias gdc='git diff --cached'

# capi likes `alias g="git status"`, other teams like `alias g=git`, so do both:
alias g  >/dev/null 2>&1 && unalias g

function g() {
    case $# in
	0) git status ;;
	*) git "$@" ;;
    esac
}

# Misc aliases
alias fl="fly -t ci login -c https://ci.cli.fun -n main -b"
alias cfu="seed_users"
alias where_my_bosh_lites_at="print_env_info"
alias bosh_lites="print_env_info"

function int() {
	export CF_INT_API=https://api.$BOSH_LITE_DOMAIN

	credhub login --skip-tls-validation
	export CF_INT_PASSWORD=$(credhub get --name '/bosh-lite/cf/cf_admin_password' --output-json | jq -r '.value')
}
