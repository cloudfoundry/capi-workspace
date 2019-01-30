#FASD
alias v='fasd -e vim'
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

alias b='bundle exec'
alias bake='DB=postgres bundle exec rake'
alias slowbake='DB=mysql bundle exec rake'

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
alias lazy="git pull -r && fixcommitter && make && git push"
alias cfu="seed_users"

