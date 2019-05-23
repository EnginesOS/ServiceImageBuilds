#!/bin/sh
 . /home/engines/functions/checks.sh
 
 domain_name=$1
required_values="domain_name"
check_required_values
if test -f /etc/opendkim/keys/$domain_name/mail.private
 then
  echo '{"error":"Domain key exists for '$domain_name'"}'
  exit 2
 fi

domain_dir=/etc/opendkim/keys/$domain_name
mkdir -p $domain_dir

cd $domain_dir
opendkim-genkey -t -s mail -d $domain_name
chmod ugo+r $domain_dir/mail.txt

/home/engines/scripts/engine/sudo/rebuild_dkim.key.sh
 echo '{"Success":"Domain key for '$domain_name' Created"}'
exit 0

