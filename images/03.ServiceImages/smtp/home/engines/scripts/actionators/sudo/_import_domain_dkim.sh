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
cat - > $domain_dir/mail.private
chmod go-rw $domain_dir/mail.private
chown opendkim -R $domain_dir
mv /tmp/public > $domain_dir/mail.txt
chmod g+r $domain_dir/mail.txt

 echo '{"Success":"Domain key for '$domain_name' Imported"}'
exit 0
