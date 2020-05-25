if [ ! -e "${HOME}/.inputrc" ]; then
	cat << EOF > "${HOME}/.inputrc"
set completion-ignore-case on
EOF
fi
