#!/bin/bash
mysqldump -h $dbhost -u $dbuser --password=$dbpasswd  --all-databases > /home/backup/sql_dumps/alldatabases.sql 