#!/bin/sh

cd /home/engines/scripts/configurators/saved

max_allowed_packet=`cat max_allowed_packet`
event_scheduler=`cat event-scheduler`
sql_mode=`cat sql_mode`
local_infile=`cat local_infile`
innodb_buffer_pool_size=`cat innodb_buffer_pool_size`

rm /tmp/mysqld.cnf

cat /home/engines/templates/etc/mysql/mysql.conf.d/mysqld.cnf | while read LINE
do
 eval echo "$LINE" >> /tmp/mysqld.cnf
done

sudo -n /home/engines/scripts/engine/sudo/_install_config.sh
