#!/bin/bash
set -e

DB_PASS="$(cat /run/secrets/db_password)"

. /run/secrets/credentials
cd /var/www/html

until mariadb -h mariadb -u"$MYSQL_USER" -p"$DB_PASS" -e "SELECT 1;" &>/dev/null; do
	echo "[entrypoint] waiting for mariadb..."
	sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
	# download wordpress into the current directory (/var/www/html)
	wp core download --allow-root
	# write wp-config.php (the connection details for the DB)
	wp config create \
		--dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
		--dbpass="$DB_PASS" --dbhost=mariadb --allow-root
	# create the wp_* tables and the admin user
	wp core install \
		--url="https://$WP_URL" --title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
	# create the required second (non-admin) user
	wp user create "$WP_USER" "$WP_USER_EMAIL" \
		--role=author --user_pass="$WORDPRESS_USER_PASSWORD" --allow-root
	chown -R www-data:www-data /var/www/html
fi

exec php-fpm8.2 -F
