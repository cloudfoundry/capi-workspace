#!/bin/bash
set -e

MYSQL_PASSWORD="${MYSQL_PASSWORD:-password}"

brew services restart mysql

# Is mysql running?
for i in $(seq 60); do
	if [ -e /tmp/mysql.sock ]; then
		break
	else
		sleep 1
	fi
done

# Wait a bit to ensure MySQL is truly up and running
sleep 15

# Run mysql upgrader
mysql_upgrade -uroot -p"$MYSQL_PASSWORD" == 2 || :
sleep 15

# Change the admin password
if ! mysql -uroot -p"$MYSQL_PASSWORD" -e 'show databases' > /dev/null 2>&1; then
	echo "Setting MySQL admin password"
	mysqladmin -uroot password password
else
	echo "MySQL admin password already set"
fi
