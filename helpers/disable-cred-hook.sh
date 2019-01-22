#!/usr/bin/env bash

function disable_cred_hook {
  mkdir -p "${1}/.git/hooks"
  cat > "${1}/.git/hooks/post-merge" << EOT
#!/usr/bin/env bash

# Override the default hook that complains about credentials

exit 1
EOT
  chmod +x "${1}/.git/hooks/post-merge"
}
