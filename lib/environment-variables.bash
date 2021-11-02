export BOSH_SHA2=true

# Set nvim as default editor
export GIT_EDITOR=nvim
export EDITOR=nvim

# Setup GOPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Add capi-workspace/scripts to PATH
export PATH="$PATH:$HOME/workspace/capi-workspace/bin"


# Add CLI out directory to PATH
export PATH="$PATH:$HOME/go/src/code.cloudfoundry.org/cli/out"
# Add brew-installed python to the path.
# Must go at the beginning so that it's prioritized over the system installation.
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# specify locale so vim will stop shouting
export LC_ALL=en_US.UTF-8

launchctl setenv PATH $PATH