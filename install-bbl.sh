#!/bin/bash

set -e

# This will not be needed once we catch up with the bbl version on brew
# Then we can install bbl using the Brewfile
function install_bbl {
	if ! which bbl > /dev/null ; then
                echo "Installing bbl"
		local destination=/usr/local/bin/bbl
		wget "https://github.com/cloudfoundry/bosh-bootloader/releases/download/v4.10.4/bbl-v4.10.4_osx" -O $destination
		chmod +x $destination
	fi
}

install_bbl
