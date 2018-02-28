#!/bin/bash
set -e

brew link git-duet

capi_authors="${PWD}/assets/git-authors"
authors_link="${HOME}/.git-authors"
ln -fs "${capi_authors}" "${authors_link}"
