#!/bin/sh
 . /home/engines/functions/checks.sh
 
domain_name=$1

required_values="domain_name"
check_required_values
domain_dir=/home/engines/scripts/configurators/saved/dkim/keys/$domain_name
mkdir -p $domain_dir
cat - > $domain_dir/mail.private
chmod go-rw $domain_dir/mail.private
chown opendkim -R $domain_dir
mv /tmp/public > $domain_dir/mail.txt
chmod g+r $domain_dir/mail.txt

