#!/bin/sh -x
echo "Add Volumes $?"  >> /client/log/fs_setup.log
cd /dest/fs/

if test $1 = 'all'
 then 
  vols=`ls`
 else
  vols=$?  
fi
  
for dir in $vols
 do 
 	chown -R $fw_user /dest/fs/$dir  >> /client/log/fs_setup.log  >> /client/log/fs_setup.err 2>&1
 	chmod g+ws -R  /dest/fs/$dir  >> /client/log/fs_setup.log  >> /client/log/fs_setup.err 2>&1
 	chmod o-rw -R  /dest/fs/$dir  >> /client/log/fs_setup.log  >> /client/log/fs_setup.err 2>&1
 done