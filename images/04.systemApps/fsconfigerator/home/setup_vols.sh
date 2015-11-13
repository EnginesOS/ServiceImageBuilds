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

if test -f /dest/fs/.persistant_lock
 then
  chown -R $fw_user /dest/fs/*
else

	cd /home/fs_src/
	
	for dest_dir in `ls /dest/fs/`
	 do	 
	   src_dir=`echo $dest_dir | sed "/_/s//\//g" | sed " /\/home\/fs/s//\/home\/fs_src/" `
	   cp -rpn $src_dir/. /dest/fs/$dest_dir
	   chown -R ${fw_user}.${data_gid}  /dest/fs/$dir
	 done

	#if no presistance dirs/files need to set permission here
	
	chown  ${fw_user}.${data_gid}  /dest/fs/
	chmod g+w  /dest/fs/
	
	if test -d /home/app_src
		then
			cp -rp /home/app_src/. /dest/app			
			chown -R ${fw_user}.${data_gid}  /dest/app 	
			chmod g+w -R /dest/app	
			touch /dest/app/.persistant		
    fi
    
	touch /dest/fs/.persistant
fi

touch /client/state/flags/volume_setup_complete

 exit 0
