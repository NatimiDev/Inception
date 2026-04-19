#!/bin/bash
set -e

echo "Waiting for MariaDB..."

until mysqladmin ping -h mariadb -uroot -p$MYSQL_ROOT_PASSWORD --silent; do
    sleep 1
done

echo "MariaDB is up!"

cd /var/www/html

echo "Current files:"
ls -la

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Installing WordPress..."

    wp core download --allow-root

    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create --allow-root \
        $WP_USER $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD

    echo "WordPress installed!"
fi

exec php-fpm8.2 -F
