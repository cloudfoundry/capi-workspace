#!/bin/bash
# run this script on newly provisions VMs to create remote workstations
# bash <(curl -s https://raw.githubusercontent.com/cloudfoundry/capi-workspace/main/bootstrap.sh)

mkdir -p ~/workspace
cd ~/workspace
echo "Cloning the capi-workspace repo"
git clone https://github.com/cloudfoundry/capi-workspace.git

cd capi-workspace
echo "Installing required packages and tools, you may be prompted for your sudo password."
./install.sh
cd ~

echo "All done! Disconnect and log back in to ensure you have everything."

