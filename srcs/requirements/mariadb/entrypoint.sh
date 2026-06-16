#!/bin/bash
set -e

DB_ROOT_PASS=$(cat /run/secrets/db_root_password)
DB_PASS=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

# setup the db
if [ ! -d "/var/lib/mysql/mysql" ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db --auth-root-authentication-method=normal >/dev/null
	mariadbd --user=mysql --skip-networking &
	pid="$!"
	until mariadb-admin ping --silent; do #wait until the server answers before we send SQL
		sleep 1
	done
	mariadb << EOSQL
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
FLUSH PRIVILEGES;
EOSQL
	mariadb-admin --user=root --password="${DB_ROOT_PASS}" shutdown
	wait "$pid"
fi

exec mariadbd --user=mysql
