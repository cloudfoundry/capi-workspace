#!/usr/bin/env bash

alias vim=nvim

# fasd
alias v='fasd -e vim'
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# ruby
alias b='bundle exec'
alias bake='echo "bundling..." && bundle install --quiet && echo "done bundling" && bundle exec rake'
alias pgbake='echo "bundling..." && bundle install --quiet && echo "done bundling" && DB=postgres bundle exec rake'
alias mybake='echo "bundling..." && bundle install --quiet && echo "done bundling" && DB=mysql bundle exec rake'

# k8s
alias k=kubectl

# Git aliases
alias gd='git diff'
alias gdc='git diff --cached'
alias gst='git status'