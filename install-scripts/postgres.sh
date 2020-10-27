#!/bin/bash
set -e

if [ "$(uname)" = "Darwin" ]; then

	brew link postgresql@9.6 --force
	brew services start postgresql@9.6

	# Is postgres running?
	for i in $(seq 60); do
		if brew services list | grep postgresql | grep -q started; then
			break
		else
			sleep 1
		fi
	done

	# Change the admin password
	# How does this actually change the password?
	if ! psql -U postgres -c "select 1" &> /dev/null; then
		echo "Setting postgres user"
		createuser -U "$(whoami)" --superuser postgres
	else
		echo "postgres user already created"
	fi
else
	sudo sed -i 's/peer/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
	sudo sed -i 's/md5/trust/' "$(find /etc/postgresql -name pg_hba.conf)"
	sudo service postgresql restart
fi


