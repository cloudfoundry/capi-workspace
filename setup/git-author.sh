#!/bin/bash
set -e

function uninstall_git_duet {
	brew uninstall git-duet -f

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

uninstall_git_duet

capi_authors="${PWD}/assets/git-authors"
together_link="${HOME}/.git-together"
ln -fs "${capi_authors}" "${together_link}"

git config --global include.path "${together_link}"
