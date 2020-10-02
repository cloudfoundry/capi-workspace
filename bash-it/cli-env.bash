# Always use the built version of the cf cli
export PATH="$HOME/go/src/code.cloudfoundry.org/cli/out:$PATH"

# Target V7 by default
export TARGET_V7=true
export GOFLAGS='--tags=V7'
