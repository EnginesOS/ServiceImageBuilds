#!/bin/sh

mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname < /home/auth/create_tables.sql