#!/bin/bash
set -e

desired_prefs="${HOME}/workspace/capi-workspace/assets/com.divisiblebyzero.Spectacle.plist"
current_prefs="${HOME}/Library/Preferences/com.divisiblebyzero.Spectacle.plist"

if ! diff "${desired_prefs}" "${current_prefs}"; then
	cp -f "${desired_prefs}" "${current_prefs}"
fi
