#!/bin/sh
 . /home/engines/functions/checks.sh
 
 domain_name=$1
required_values="domain_name"
check_required_values

domain_dir=/home/engines/scripts/configurators/saved/dkim/keys/$domain_name
mkdir -p $domain_dir

cd $domain_dir
opendkim-genkey -t -s mail -d $domain_name
chmod ugo+r $domain_dir/mail.txt

/home/engines/scripts/engine/rebuild_dkim.key.sh



