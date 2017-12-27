#!/bin/sh -x
echo Setup Engine user $fw_user
#VOLUME /client/var/log
#VOLUME /client/log
#VOLUME /client/state
#VOLUME /home/fs
#VOLUME /dest/fs

echo Contents of /client/var/log
ls /client/var/log

echo Contents of /client/log 
ls /client/log

echo Contents of /client/state
ls /client/state

echo Contents of dest/fs
ls /dest/fs

echo Contents of /home/fs
ls /home/fs


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


	cd /home/fs_src/
	echo "moving fs src "
	ls /dest/fs/
	
	for dest_dir in `ls /dest/fs/`
	 do	 
	 if test -f /dest/fs/$dest_dir/.persistent_lock
 		then
 		echo "Already persistent $dest_dir"
 		 chown -R $fw_user /dest/fs/$dest_dir
  		  chmod g+w -R  /dest/fs/$dest_dir
 		continue
 		fi
	   src_dir=`echo $dest_dir | sed "/_/s//\//g" | sed " /\/home\/fs/s//\/home\/fs_src/" `
	   cp -rpn $src_dir/. /dest/fs/$dest_dir
	   	   touch /dest/fs/$dest_dir/.persistent_lock
	   chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_dir
	   echo "setup $dest_dir"
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
			echo "Setup app persist"
    fi

touch /client/state/flags/volume_setup_complete
echo setup complete
 exit 0
