#!/bin/bash
new_user_ldif=`mktemp`

kinit -kt /etc/krb5kdc/keys/ftp.keytab 

uid=`/home/engines/scripts/services/next_id.sh`
 if test $? -ne 0
  then 
   exit 1
  fi

cat /home/engines/templates/ftp/new_user.ldif \
 | sed "s/SN/$service_handle/g" \
 | sed "s/IDNUMBER/$uid/" \
 | sed "s/GID/${ftp_gid}/" \
 | sed "s/PASSWORD/${password}/" \
 | sed "s/UID/${service_handle}/" > $new_user_ldif
 # \
 #| sed "s/USER/${username}/" > $new_user_ldif
 
#set the volume

echo /ftp/$access/$parent_engine/$volume/$folder >> $new_user_ldif

cat $new_user_ldif | ldapadd -H ldap://ldap/
 if test $? -ne 0
  then 
   exit 1
  fi
/home/engines/scripts/services/add_to_ftp_group.sh ${service_handle}
r=$?
cp $new_user_ldif /tmp/new_user_ldif
rm $new_user_ldif
#dont leave ticket open
kdestroy 
  
exit $r
 

