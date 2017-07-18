#!/bin/bash

. /home/auth/.dbenv
mysqldump -h $dbhost -u $dbuser --password=$dbpasswd $dbname 