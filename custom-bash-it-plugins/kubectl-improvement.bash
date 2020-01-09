
source <(kubectl completion bash)

alias k=kubectl
complete -F __start_kubectl k

source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
