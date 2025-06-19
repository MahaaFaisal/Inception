#!/usr/bin/env bash

echo >> $DB_CONF
echo "[mysqld]" >>$DB_CONF
echo "bind-address=0.0.0.0" >> $DB_CONF # allows it to listen on all available network interfaces
echo "max_connections = 200" >> $DB_CONF

if [ ! -d "$DB_INSTALL/mysql" ]; then
	mysql_install_db --datadir="$DB_INSTALL"
fi

mysqld_safe & mysql_pid=$!

until mysqladmin ping > /dev/null 2>&1; do
	echo -n "*"; sleep 0.2
done

mysql -u root -e"CREATE DATABASE IF NOT EXISTS $DB_NAME;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
	GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
	FLUSH PRIVILEGES;"

wait $mysql_pid
