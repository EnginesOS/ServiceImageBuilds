#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/dyndns_settings
parms_to_file_and_env

required_values="provider login login domain_name password"
check_required_values

cat /home/engines/templates/dyndns/providers/$provider/dyndns.conf.tmpl |sed --e /LOGIN/s//$login/ -e /PASSWORD/s//$password/ -e /DOMAIN/s//$domain_name/ >/home/dyndns/dyndns.conf 
chmod og-r /home/dyndns/dyndns.conf
echo "Success"
exit 0
