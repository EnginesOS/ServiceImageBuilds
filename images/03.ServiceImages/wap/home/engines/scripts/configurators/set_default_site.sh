#!/bin/sh

echo $default_site_url > /home/engines/scripts/configurators/saved/default_site

 . /home/engines/functions/checks.sh
required_values="default_site"
check_required_values    
  
if test  ${#default_site_url} -gt 4
 then  
  cat /etc/nginx/templates/default_site.tmpl | sed "/FQDN/s//$default_site/" > /tmp/site.fqdn
  cp /tmp/site.fqdn /etc/nginx/sites-enabled/default
else
  cp /etc/nginx/templates/empty_default /etc/nginx/sites-enabled/default 	
fi

kill -HUP `cat /home/engines/run/nginx.pid`
exit 0
