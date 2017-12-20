#!/bin/bash

kinit -t /etc/krb5kdc/keys/ftp.keytab 

uid=`/home/engines/scripts/services/next_id.sh`

cat /home/engines/templates/ftp/new_user.ldif \
 | sed "s/SN/$service_handle/" \
 | sed "s/IDNUMBER/$uid/" \
 | sed "s/GID/${ftp_gid}/" \
 | sed "s/PASSWORD/${password}/" \
 | sed "s/UID/${service_handle}\/${service_container_name}/" \
 | sed "s/USER/${username}/" > /tmp/newuser.ldif
 
 echo /ftp/$access/$parent_engine/$volume/$folder >> /tmp/newuser.ldif

cat /tmp/newuser.ldif | ldapadd -H ldap://ldap/
/home/engines/scripts/services/add_to_ftp_group.sh ${service_handle}/${service_container_name}


#dont leave ticket open
#kdestroy
  
 

