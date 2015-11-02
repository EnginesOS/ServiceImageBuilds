#!/bin/bash
mysqldump -h mysql -u $dbuser --password=$dbpasswd  --all-databases > /home/backup/sql_dumps/alldatabases.sql 
