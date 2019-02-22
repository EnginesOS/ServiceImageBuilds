#!/bin/sh -x

#VOLUME /client/var/log
#VOLUME /client/log
#VOLUME /client/state
#VOLUME /home/fs
#VOLUME /dest/fs

logs=`ls /var/log/`
echo logs
for log in $logs
 do
	cp -rp /var/log/$log  /client/var/log
done

chown $fw_user -R /client/log/
chown $fw_user -R /client/var/log
mkdir -p /client/state/flags
chown $fw_user -R /client/state
chgrp 22020  -R /client/state
chmod g+w  -R /client/state

#if test -f /dest/fs/.persistent_lock
# then
#  chown -R $fw_user /dest/fs/*
#  chmod g+w -R  /dest/fs/*
  
#else

	cd /home/fs_src/
	
	for dest_dir in `ls /dest/fs/`
	 do	 
	  if test -f /dest/fs/$dest_dir/.persistent_lock
 		then
 		 chown -R $fw_user /dest/fs/$dest_dir
  		  chmod g+w -R  /dest/fs/$dest_dir
 		continue
       fi
	 src_dir=`echo $dest_dir | sed "/_/s//\//g" | sed " /\/home\/fs/s//\/home\/fs_src/" `
	 cp -rpn $src_dir/. /dest/fs/$dest_dir
	 touch /dest/fs/$dest_dir/.persistent_lock
	 chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_dir
	 echo CHMOD -R g+w /dest/fs/$dest_dir
	 chmod -R g+w /dest/fs/$dest_dir
	done

	#if no presistance dirs/files need to set permission here
	
	chown  21000.${data_gid}  /dest/fs/
	chmod g+w -R  /dest/fs/*
	chmod g+rx ` find /dest/fs/ -type d`
	
	if test -d /home/app_src
		then
			cp -rp /home/app_src/.  /dest/fs/_home_app_/			
			chown -R ${fw_user}.${data_gid}  /dest/fs/_home_app_/			
			touch /dest/fs/_home_app_/.persistent
	        chmod -R g+w /dest/fs/$dest_dir
    fi

	#touch /dest/fs/.persistent_lock
	#touch /dest/fs/.persistent
	
#fi


chown -R ${fw_user}.${data_gid}    /home/home_dir/.ssh
touch /client/state/flags/volume_setup_complete

 exit 0
