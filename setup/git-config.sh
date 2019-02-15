#!/bin/bash

WORKSPACE=${PWD}
SOURCE="${PWD}/assets/gitconfig"
TARGET="${HOME}/.gitconfig"

if [ -L "${TARGET}" ]; then
		# If the global git config is symlinked, remove the symlink
    unlink "${TARGET}"
fi

if [ -e "${TARGET}" ]; then
		# If the global git config exists, back it up before modifying
    echo Copying \"${TARGET}\" to \"${TARGET}.bak\"
    cp "${TARGET}" "${TARGET}.bak"
else
		# If the global git config doesn't exist, copy it from capi-workspace
    cp "${SOURCE}" "${TARGET}"
fi

# Copy the aliases from the git config stored in capi-workspace to the global git config
ruby -rinifile -e 1 2>/dev/null || gem install inifile
iniSrcPath=$(gem which inifile 2>/dev/null)

# inifile is an abandoned rubygem, so apply the force_array patch locally
if ! grep -q force_array "$iniSrcPath" ; then
    inifileRoot=$(dirname $(dirname "$iniSrcPath"))
    pushd "$inifileRoot" > /dev/null
        patch --forward -p 1 < "$WORKSPACE/assets/inifile.patch" || true
    popd 2>&1 > /dev/null
fi
ruby -rinifile "${PWD}/helpers/transfer-git-aliases.rb" "${SOURCE}" "${TARGET}"
