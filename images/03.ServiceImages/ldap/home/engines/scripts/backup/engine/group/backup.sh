#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
. $SCRIPTPATH/set_group_dn.sh

 if test -z $group_dn
  then
   echo group_dn cant be nill
   exit -1
  fi 

ldapsearch -D ${ldap_dn} -w ${ldap_password} -h ${LDAP_HOST} -b $group_dn
 
