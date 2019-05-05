#!/bin/sh
for user in `cat -` 
do
 if ! test -d  /var/fs/homes/$user
  then 
  continue
 fi 
 mkdir /var/fs/homes/$user/$parent_engine
 chmod g+rwx /var/fs/homes/$user/$parent_engine
 chgrp 11111 /var/fs/homes/$user/$parent_engine
done 
#mkdir -p /var/fs/local/${parent_engine}/${service_name}
#chown -R ${user}.${group} /var/fs/local/${parent_engine}/${service_name}
#chmod g+w /var/fs/local/${parent_engine}/${service_name}
#chmod o-rxw /var/fs/local/${parent_engine}/${service_name}
