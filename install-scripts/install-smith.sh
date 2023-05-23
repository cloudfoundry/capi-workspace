#!/bin/bash
set -ex

echo "setting up toolsmiths creds..."
pushd ~

printf '%s\n' '#!/bin/bash' 'lpass show --password "Toolsmiths GCP Env Pool Creds"'> .smith-token-hook.sh
chmod 777 .smith-token-hook.sh

echo "installing smith cli..."
cd workspace
[ ! -e "smith" ] && git clone git@github.com:pivotal/smith.git
cd smith && git pull
go install
popd


