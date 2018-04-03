#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/default_site_url
params_to_file_and_env

required_values="default_site_url"
check_required_values    
  
if test  ${#default_site_url} -gt 4
 then  
  cat /etc/nginx/templates/default_site.tmpl | sed "/FQDN/s//$default_site_url/" > /tmp/site.fqdn
  cp /tmp/site.fqdn /etc/nginx/sites-enabled/default
else
  cp /etc/nginx/templates/empty_default /etc/nginx/sites-enabled/default 	
fi

kill -HUP `cat /home/engines/run/nginx.pid`
exit 0
