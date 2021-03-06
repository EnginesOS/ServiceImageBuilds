#!/bin/sh

 . /home/engines/functions/checks.sh
 required_values="provider login domain_name password"
check_required_values

echo -n $login > /home/engines/scripts/configurators/saved/login
echo -n $provider > /home/engines/scripts/configurators/saved/provider
echo -n "$domain_name" > /home/engines/scripts/configurators/saved/domain_name
echo -n "$password" > /home/engines/scripts/configurators/saved/password


login=`echo $login | sed "/:/s//%23/"`
cat /home/engines/templates/dyndns/providers/$provider/dyndns.conf.tmpl |sed --e /LOGIN/s//$login/ -e /PASSWORD/s//$password/ -e /DOMAIN/s//$domain_name/ >/home/dyndns/dyndns.conf 
chmod og-r /home/dyndns/dyndns.conf
echo "Success"
exit 0
