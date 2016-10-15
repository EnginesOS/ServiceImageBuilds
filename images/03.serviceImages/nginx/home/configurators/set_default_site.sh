#!/bin/bash

cat - >/home/configurators/saved/default_site_url

cat /home/configurators/saved/default_site_url | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


        
   	if test  ${#default_site_url} -gt 4
	then  
	
	cat /etc/nginx/templates/default_site.tmpl | sed "/FQDN/s//$default_site_url/" > /tmp/site.fqdn
	 cp /tmp/site.fqdn /etc/nginx/sites-enabled/default

 else
 	cp 	cat /etc/nginx/templates/empty_default /etc/nginx/sites-enabled/default 	
 	fi
 
exit 0
