#!/bin/bash

until mysqladmin ping -h mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD --silent; do
    sleep 1
done

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f "/var/www/html/wp-config.php" ]; then
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
fi

exec php-fpm8.2 -F
