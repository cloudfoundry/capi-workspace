#!/bin/bash

brew tap 'git-duet/tap'

brew link git-duet

capi_authors="${PWD}/git-authors"
authors_link="${HOME}/.git-authors"
ln -s "${capi_authors}" "${authors_link}"
