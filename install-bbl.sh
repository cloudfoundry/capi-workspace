#!/bin/bash

set -e

# This will not be needed once we catch up with the bbl version on brew
# Then we can install bbl using the Brewfile
function install_bbl {
	if ! which bbl4 > /dev/null ; then
                echo "Installing bbl 4"
		local destination=/usr/local/bin/bbl4
		wget "https://github.com/cloudfoundry/bosh-bootloader/releases/download/v4.10.5/bbl-v4.10.5_osx" -O $destination
		chmod +x $destination
	fi

	if ! which bbl > /dev/null ; then
                  echo "Installing bbl"
    local destination=/usr/local/bin/bbl
    wget "https://github.com/cloudfoundry/bosh-bootloader/releases/download/v6.6.11/bbl-v6.6.11_osx" -O $destination
    chmod +x $destination
  fi
}

install_bbl
