#!/bin/bash

if [ ! -f "/var/lib/mysql/.inited" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld_safe --datadir=/var/lib/mysql &

    until mysqladmin ping -uroot --silent; do
        sleep 1
    done

    mysql -uroot << EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

    mysqladmin -uroot shutdown

    touch /var/lib/mysql/.inited
fi

exec mysqld_safe --datadir=/var/lib/mysql
