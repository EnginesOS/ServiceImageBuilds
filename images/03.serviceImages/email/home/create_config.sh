#!/bin/bash

. /home/.dbenv

if test -f /home/configurators/saved/default_domain
	then
		service_hash=`cat /home/configurators/saved/default_domain`	
		. /home/engines/scripts/functions.sh
		load_service_hash_to_environment
     else
      	default_domain=$DEFAULT_DOMAIN
 fi

cat /home/app/_config.inc.php \
 | sed "/DBHOST/s//$dbhost/"\
	| sed  "/DBNAME/s//$dbname/"\
	| sed  "/DBUSER/s//$dbuser/"\
	| sed   "/DBPASSWD/s//$dbpasswd/"\
	| sed   "/DEFAULT_DOMAIN/s//$default_domain/" > /home/app/config.inc.php
	
	