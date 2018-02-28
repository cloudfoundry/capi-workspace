#!/bin/bash

set -e

SOURCE="${PWD}/assets/gitconfig"
TARGET="${HOME}/.gitconfig"

if [ ! -e "${TARGET}" ] ; then
    ln -s "${SOURCE}" "${TARGET}"
elif diff --brief "${SOURCE}" "${TARGET}" ; then
    echo "no change needed for \"${TARGET}\""
else
    echo Copying \"${TARGET}\" to \"${TARGET}.bak\"
    cp "${TARGET}" "${TARGET}.bak"
    ruby -rinifile -e 1 2>/dev/null || gem install inifile
    ruby -rinifile "${PWD}/helpers/transfer-git-aliases.rb" "${SOURCE}" "${TARGET}"
fi
