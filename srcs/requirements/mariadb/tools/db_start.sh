#!/usr/bin/env bash

echo >> $DB_CONF
echo >> "[mysqld]" >>$DB_CONF
echo >> "bind-address=0.0.0.0" >> $DB_CONF # allows it to listen on all available network interfaces

mysql_install_db --datadir=$DB_INSTALL