#!/bin/bash
new_user_ldif=`mktemp`

kinit -kt /etc/krb5kdc/keys/ftp.keytab 

uid=`/home/engines/scripts/services/next_id.sh`
kinit -kt /etc/krb5kdc/keys/ftp.keytab 

cat /home/engines/templates/ftp/new_user.ldif \
 | sed "s/SN/$service_handle/g" \
 | sed "s/IDNUMBER/$uid/" \
 | sed "s/GID/${ftp_gid}/" \
 | sed "s/PASSWORD/${password}/" \
 | sed "s/UID/${service_handle}\/${service_container_name}/" \
 | sed "s/USER/${username}/" > $new_user_ldif
 
 echo /ftp/$access/$parent_engine/$volume/$folder >> $new_user_ldif

cat $new_user_ldif | ldapadd -H ldap://ldap/
/home/engines/scripts/services/add_to_ftp_group.sh ${service_handle}/${service_container_name}
r=$?
rm $new_user_ldif
#dont leave ticket open
kdestroy 
  
exit $r
 

