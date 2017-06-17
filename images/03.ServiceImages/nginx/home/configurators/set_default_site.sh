#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/configurators/saved/default_site_url
parms_to_file_and_env

        
if test  ${#default_site_url} -gt 4
 then  
  cat /etc/nginx/templates/default_site.tmpl | sed "/FQDN/s//$default_site_url/" > /tmp/site.fqdn
  cp /tmp/site.fqdn /etc/nginx/sites-enabled/default
else
  cp cat /etc/nginx/templates/empty_default /etc/nginx/sites-enabled/default 	
fi

kill -HUP `cat /run/nginx/nginx.pid`
exit 0
