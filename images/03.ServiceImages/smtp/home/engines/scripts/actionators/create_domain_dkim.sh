#!/bin/sh
 . /home/engines/functions/checks.sh
 
 
required_values="domain_name"
check_required_values

sudo -nu opendkim /home/engines/scripts/engine/_create_domain_dkim.sh $domain_name



