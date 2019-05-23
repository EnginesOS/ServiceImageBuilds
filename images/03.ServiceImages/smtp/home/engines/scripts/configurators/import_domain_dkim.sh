#!/bin/sh
 . /home/engines/functions/checks.sh
 
 
required_values="domain_name private public"
check_required_values

echo $public >/tmp/public

echo $private | sudo -nu opendkim /home/engines/scripts/configurators/sudo/_import_domain_dkim.sh $domain_name
