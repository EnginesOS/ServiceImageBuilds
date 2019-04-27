#!/bin/sh
for user in `cat -` 
do
 if ! test -d  /var/lib/engines/home/$user
  then 
  continue
 fi 
 mkdir /var/lib/engines/home/$user/$parent_engine
 chmod g+rwx /var/lib/engines/home/$user/$parent_engine
 chgrp containers /var/lib/engines/home/$user/$parent_engine
done 
#mkdir -p /var/fs/local/${parent_engine}/${service_name}
#chown -R ${user}.${group} /var/fs/local/${parent_engine}/${service_name}
#chmod g+w /var/fs/local/${parent_engine}/${service_name}
#chmod o-rxw /var/fs/local/${parent_engine}/${service_name}
