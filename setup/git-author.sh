#!/bin/bash
set -ex

source ./helpers/clone.sh

function uninstall_git_duet {
	rm -f "${HOME}/.git-authors"

	set +e
	git config --global --unset duet.env.git-author-initials
	git config --global --unset duet.env.git-author-name
	git config --global --unset duet.env.git-author-email
	git config --global --unset duet.env.mtime
	git config --global --unset duet.env.git-committer-initials
	git config --global --unset duet.env.git-committer-name
	git config --global --unset duet.env.git-committer-email
	set -e
}

function install_git_author {
	pushd "${HOME}/workspace"
		clone https://github.com/pivotal/git-author.git
		pushd git-author
			./setup.sh
		popd
	popd
}

uninstall_git_duet
install_git_author

capi_authors="${PWD}/assets/git-authors"
authors_link="${HOME}/.git-together"
ln -fs "${capi_authors}" "${authors_link}"

git config --global include.path "${authors_link}"
