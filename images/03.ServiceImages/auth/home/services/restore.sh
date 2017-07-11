#!/bin/bash

. /home/auth/.dbenv
cat - | gzip -d | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 