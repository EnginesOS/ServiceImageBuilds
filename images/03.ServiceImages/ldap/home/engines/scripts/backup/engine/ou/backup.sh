#!/bin/sh
 
 #!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
. $SCRIPTPATH/set_ou_dn.sh

 if test -z $ou_dn
  then
   echo ou_dn cant be nill
   exit -1
  fi 
  
ldapsearch -D ${ldap_dn} -w ${ldap_password} -h ${LDAP_HOST} -b $ou_dn


#ldapsearch -D ${ldap_dn} -w ${ldap_password} -h ${LDAP_HOST} -b ou=${ldap_ou},ou=${parent_engine},ou=Applications,ou=Containers,ou=Engines,dc=engines,dc=internal 
 