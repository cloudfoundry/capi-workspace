function int() {
	export CF_INT_API=https://api.$BOSH_LITE_DOMAIN

	credhub login --skip-tls-validation
	export CF_INT_PASSWORD=$(credhub get --name '/bosh-lite/cf/cf_admin_password' --output-json | jq -r '.value')
}
