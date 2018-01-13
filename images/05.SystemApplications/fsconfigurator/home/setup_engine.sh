#!/bin/sh -x
echo Setup Engine user $fw_user
#VOLUME /client/log
#VOLUME /client/log
#VOLUME /client/state
#VOLUME /home/fs
#VOLUME /dest/fs

echo Contents of /client/log >> /client/log/fs_setup.log
ls /client/log > /client/log/fs_setup.log

echo Contents of /client/log  >> /client/log/fs_setup.log

ls /client/log >> /client/log/fs_setup.log

echo Contents of /client/state >> /client/log/fs_setup.log
ls /client/state >> /client/log/fs_setup.log

echo Contents of dest/fs >> /client/log/fs_setup.log

ls /dest/fs >> /client/log/fs_setup.log

echo Contents of /home/fs >> /client/log/fs_setup.log

ls /home/fs >> /client/log/fs_setup.log


logs=`ls /var/log/`
echo logs
for log in $logs
 do
	cp -rp /var/log/$log  /client/log/
done

chown $fw_user -R /client/log/
chown $fw_user -R /client/log
mkdir -p /client/state/flags
chown $fw_user -R /client/state
touch client/state/flags/fsconfigurated
chgrp 22020  -R /client/state
chmod g+w  -R /client/state


	cd /home/fs_src/
	echo "moving fs src "  >> /client/log/fs_setup.log
	ls -R /dest/fs/  >> /client/log/fs_setup.log
	echo Contents of /home/fs_src >> /client/log/fs_setup.log
	ls /home/fs_src >> /client/log/fs_setup.log
	
	for dir in `cat /home/fs_src/vol_dir_maps`
	 do
	  volume=`grep "$dir " /home/fs_src/vol_dir_maps | awk '{print $2}'`
	  echo move $dir to $volume >> /client/log/fs_setup.log
	  if test -f /dest/fs/$volume/.persistent_lock
	   then 
	   	echo Persistence configured for $volume  >> /client/log/fs_setup.log
	   else
	  	echo Install dir $dir in /$volume >>/client/log/test.out
	  	if ! test -d /dest/fs/$volume/`dirname $dir`
	  	 then
	  	 mkdir -p /dest/fs/$volume/`dirname $dir`
	  	 echo	mkdir -p /dest/fs/$volume/`dirname $dir`>> /client/log/fs_setup.log
	  	fi
	  		echo cp -nrp /home/fs_src/$dir /dest/fs/$volume/$dir>> /client/log/fs_setup.log
	   		cp -nrp /home/fs_src/$dir /dest/fs/$volume/$dir
	   		chown -R ${fw_user}.${data_gid}  /dest/fs/$volume/$dir
	   fi
	 done
	 
	 for file in `cat /home/fs_src/vol_file_maps`
	 do	 
	  volume=`grep "$file " /home/fs_src/vol_file_maps | awk '{print $2}'`	
	    echo move $file to $volume >> /client/log/fs_setup.log
	  if test -f /dest/fs/$volume/.persistent_lock
	   then 
	   	echo Persistence configured for $volume  >> /client/log/fs_setup.log
	   else
	  	echo Install dir $file in /$volume >>/client/log/test.out
	  	if ! test -d /dest/fs/$volume/`dirname $file`
	  	 then
	  	 	echo mkdir -p /dest/fs/$volume/`dirname $file`>> /client/log/fs_setup.log
	  	 	mkdir -p /dest/fs/$volume/`dirname $file`
	  	fi
	  	echo cp -np /home/fs_src/$file /dest/fs/$volume/$file  >> /client/log/fs_setup.log
	   		cp -np /home/fs_src/$file /dest/fs/$volume/$file
	   		chown -R ${fw_user}.${data_gid}  /dest/fs/$volume/$file
	   fi
	 done
	 
#	for dest_dir in `ls /dest/fs/`
#	 do	 
#	   if test -f /dest/fs/$dest_dir/.persistent_lock
# 		then
# 		 echo "Already persistent $dest_dir"  >> /client/log/fs_setup.log
# 		 chown -R $fw_user /dest/fs/$dest_dir
#  		 chmod g+w -R  /dest/fs/$dest_dir
# 		 continue
# 		fi
#	 src_dir=`echo $dest_dir | sed "/_/s//\//g" | sed " /\/home\/fs/s//\/home\/fs_src/" `
#	 cp -rpn $src_dir/. /dest/fs/$dest_dir
#	 touch /dest/fs/$dest_dir/.persistent_lock
#	 chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_dir
#	 echo "setup $dest_dir" >> /client/log/fs_setup.log
#	done
#
#	#if no presistance dirs/files need to set permission here
	
	#chown  21000.${data_gid}  /dest/fs/
	#chmod g+w -R  /dest/fs/*
	#chmod g+rx ` find /dest/fs/ -type d`
	
	if test -d /home/app_src
		then
			volume=`grep "/home/app " /home/fs_src/vol_dir_maps | awk '{print $2}'`
			cp -rp /home/app_src/.  /dest/fs/$volume/_home_app_/			
			chown -R ${fw_user}.${data_gid}  /dest/fs/$volume/_home_app_/			
			touch /dest/fs/_home_app_/.persistent
			echo "Setup app persist" >> /client/log/fs_setup.log
    fi

if test -f /client/state/flags/debug_engine_fs_setup
 then
  sleep 300
fi 
touch /client/state/flags/volume_setup_complete
echo setup complete >> /client/log/fs_setup.log
 exit 0
