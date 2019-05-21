#!/bin/sh
 . /home/engines/functions/checks.sh
 
domain_name=$1

required_values="domain_name"
check_required_values

mkdir -p /etc/dkim/keys/$domain_name
cat - > /etc/dkim/keys/$domain_name/default.private
mv /tmp/public > /etc/dkim/keys/$domain_name/default.txt

