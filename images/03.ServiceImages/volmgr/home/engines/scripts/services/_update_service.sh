#!/bin/bash
echo chown ${user}.${group} /var/fs/local/${parent_engine}/${service_name} >/tmp/cmd
chown ${user}.${group} /var/fs/local/${parent_engine}/${service_name}
 if ! test -z "$grp_write"
  then
   if test $grp_write = 'y'
    then
     chmod g+w /var/fs/local/${parent_engine}/${service_name}
   elif test $grp_write = 'n'
    then
     chmod g-w /var/fs/local/${parent_engine}/${service_name}
   fi
 fi     