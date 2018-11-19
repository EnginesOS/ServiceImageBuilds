#!/bin/bash


echo login=$login > /home/engines/scripts/configurators/saved/dyndns_settings
echo provider=$provider >> /home/engines/scripts/configurators/saved/dyndns_settings
echo provider=$domain_name >> /home/engines/scripts/configurators/saved/dyndns_settings
echo provider=$password >> /home/engines/scripts/configurators/saved/dyndns_settings

required_values="provider login domain_name password"
check_required_values
login=`echo $login | sed "/:/s//%23/"`
cat /home/engines/templates/dyndns/providers/$provider/dyndns.conf.tmpl |sed --e /LOGIN/s//$login/ -e /PASSWORD/s//$password/ -e /DOMAIN/s//$domain_name/ >/home/dyndns/dyndns.conf 
chmod og-r /home/dyndns/dyndns.conf
echo "Success"
exit 0
