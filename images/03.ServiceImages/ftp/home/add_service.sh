#!/bin/bash


. /home/engines/functions/params_to_env.sh
parms_to_env
set > /tmp/full_env
kinit  -t /etc/krb5kdc/keys/ftp.keytab 

if ! test -z
 then
  if test $rw_access -eq 1
   then
     access=rw
   else
     access=ro
   fi
 else
    access=ro
fi   
uid=`/home/next_id`
cat /home/tmpls/new_user.ldif \
 | sed "s/SN/$service_handle/" \
 | sed "s/IDNUMBER/$uid/" \
 | sed "s/UID/${service_handle}\/${service_container_name}/" \
 | sed "s/USER/${username}/" > /tmp/newuser.ldif
 
 echo /ftp/$access/$parent_engine/$volume/$folder >> /tmp/newuser.ldif


 cat /tmp/newuser.ldif | ldapadd -H ldap://ldap/
 
 #dont leave ticket open
 kdestroy
  
 

