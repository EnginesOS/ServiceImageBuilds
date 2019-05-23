#!/bin/sh
 . /home/engines/functions/checks.sh
 
required_values="domain_name"
check_required_values


cat /etc/opendkim/keys/${domain_name}/mail.txt