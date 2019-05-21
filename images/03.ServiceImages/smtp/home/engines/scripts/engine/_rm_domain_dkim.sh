#!/bin/sh
 . /home/engines/functions/checks.sh
 domain_name=$1
required_values="domain_name"
check_required_values

rm -r  /etc/dkim/keys/$domain_name

/home/engines/scripts/engine/rebuild_dkim.key.sh

