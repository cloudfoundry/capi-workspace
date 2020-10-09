#!/bin/bash
set -e

MYSQL_PASSWORD="${MYSQL_PASSWORD:-password}"

if [ "$(uname)" = "Darwin" ]; then
	brew services restart mysql
	# Is mysql running?
	for i in $(seq 60); do
		if mysql -uroot -p"$MYSQL_PASSWORD" -e 'show databases' > /dev/null 2>&1; then
			echo "MySQL is running"
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
else
	sudo service mysql start
	# Is mysql running?
	for i in $(seq 60); do
		if sudo service mysql status; then
			echo "MySQL is running"
			break
		else
			sleep 1
		fi
	done

	# Change the admin password
	if ! mysql -uroot -p"$MYSQL_PASSWORD" -e 'show databases' > /dev/null 2>&1; then
		echo "Setting MySQL admin password"
		sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_PASSWORD';"
	else
		echo "MySQL admin password already set"
	fi
fi

