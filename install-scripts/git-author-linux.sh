#!/bin/bash


# git-together on linuxbrew is broken, so we install it ourselves

# Install credhub cli
REMAINING=$(curl https://api.github.com/rate_limit 2>/dev/null | jq '.rate.remaining')
if [[ $REMAINING -eq 0 ]]; then
	echo "**NOT** Installing latest git-together"
	echo "We  hit the rate limit for the 'api.github.com' and cannot download the latest git-together Release."
	echo "Reference: https://developer.github.com/v3/#rate-limiting"
	echo
else
	echo "Installing latest git-together"
	git_together_url="$(curl https://api.github.com/repos/kejadlen/git-together/releases |  jq '.[0].assets | map(select(.name | contains("linux"))) | .[0].browser_download_url' -r)"
	curl -Lo /tmp/git_together.tgz "$git_together_url"
	sudo tar xzvf /tmp/git_together.tgz -C /usr/local/bin

	brew install git-author
fi
