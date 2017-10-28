#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env

set > /tmp/full_env

kinit -t /etc/krb5kdc/keys/ldap.keytab 

function check_required_values {
for val in $required_values 
 do

t=`eval echo \\$${key}`
if test -z $t
 then
  echo Abort no value receieved for $key
  exit 127
fi
done

}


check_required_values="type parent_engine container_type"
check_required_values


 . /home/engines/functions/ldap/support_functions.sh
 if test $container_type = container
  then
   container_type=application   
  fi
  
cat /home/engines/templates/ldap/services/add_$type.ldif | while read LINE
do
 eval echo $LINE >> $LDIF_FILE
done
cat $LDIF_FILE | /home/engines/scripts/ldap/ldapadd.sh 
kdestroy
  
 

