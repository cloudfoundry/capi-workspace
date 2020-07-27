#!/bin/bash
set -e

MYSQL_PASSWORD="${MYSQL_PASSWORD:-password}"

brew services restart mysql

# Is mysql running?
for i in $(seq 60); do
	if mysql -uroot -p"$MYSQL_PASSWORD" -e 'show databases' > /dev/null 2>&1; then
		break
	else
		sleep 1
	fi
done

# Change the admin password
if ! mysql -uroot -p"$MYSQL_PASSWORD" -e 'show databases' > /dev/null 2>&1; then
	echo "Setting MySQL admin password"
	mysqladmin -uroot password password
else
	echo "MySQL admin password already set"
fi
