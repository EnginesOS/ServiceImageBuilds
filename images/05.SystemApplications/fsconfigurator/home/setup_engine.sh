#!/bin/sh -x
echo Setup Engine user $fw_user
#VOLUME /client/log
#VOLUME /client/log
#VOLUME /client/state
#VOLUME /home/fs
#VOLUME /dest/fs


logs=`ls /var/log/`

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

for dir in `cat /home/fs_src/vol_dir_maps`
 do
  dest_volume=`grep "$dir " /home/fs_src/vol_dir_maps | awk '{print $2}'`
  echo move $dir to $dest_volume >> /client/log/fs_setup.log
   if test -z $dest_volume
    then
     continue;
   fi
     
   if test -f /dest/fs/$dest_volume/.persistent_lock
    then 
   	 echo Persistence configured for $dest_volume  >> /client/log/fs_setup.log
   else
   volumes="$volumes $dest_volume"
  	 echo Install dir $dir in /$dest_volume >>/client/log/test.out
  	  if ! test -d /dest/fs/$dest_volume/`dirname $dir`
  	   then
  	    mkdir -p /dest/fs/$dest_volume/`dirname $dir`
  	    echo	mkdir -p /dest/fs/$dest_volume/`dirname $dir`>> /client/log/fs_setup.log
  	    chown  ${fw_user}.${data_gid}  /dest/fs/$dest_volume/`dirname $dir`
  	  fi
  	
  	 echo cp -nrp /home/fs_src/$dir /dest/fs/$dest_volume/$dir>> /client/log/fs_setup.log
   	 cp -nrp /home/fs_src/$dir /dest/fs/$dest_volume/$dir
   	 chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/$dir
   fi
done
	 
for file in `cat /home/fs_src/vol_file_maps`
 do	 
  dest_volume=`grep "$file " /home/fs_src/vol_file_maps | awk '{print $2}'`	
  echo move $file to $dest_volume >> /client/log/fs_setup.log
   if test -z $dest_volume
    then
     continue;
  fi  
  if test -f /dest/fs/$dest_volume/.persistent_lock
   then 
   	echo Persistence configured for $dest_volume  >> /client/log/fs_setup.log
  else
   volumes="$volumes $dest_volume"
  	echo Install dir $file in /$dest_volume >>/client/log/test.out
  	 if ! test -d /dest/fs/$dest_volume/`dirname $file`
  	  then
  	   echo mkdir -p /dest/fs/$dest_volume/`dirname $file`>> /client/log/fs_setup.log
  	   mkdir -p /dest/fs/$dest_volume/`dirname $file`
  	   chown  ${fw_user}.${data_gid}  /dest/fs/$dest_volume/`dirname $file`
     fi
  	 
   echo cp -np /home/fs_src/$file /dest/fs/$dest_volume/$file  >> /client/log/fs_setup.log
   cp -np /home/fs_src/$file /dest/fs/$dest_volume/$file
   chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/$file
  fi
done
	 
volumes=`echo $volumes |sort|uniq`
 for vol in $volumes
  do  
   touch /dest/fs/$vol/.persistent_lock
   chown  ${fw_user}.${data_gid} /dest/fs/$vol/ /dest/fs/$vol/.persistent_lock
   chmod o-rw /dest/fs/$vol/ 
  done

#	#if no presistance dirs/files need to set permission here
	
	#chown  21000.${data_gid}  /dest/fs/
	#chmod g+w -R  /dest/fs/*
	#chmod g+rx ` find /dest/fs/ -type d`
	
if test -d /home/app_src
 then
  dest_volume=`grep "/home/app " /home/fs_src/vol_dir_maps | awk '{print $2}'`
  if ! test -f /dest/fs/$dest_volume/_home_app_/.persistent	
   then
    cp -rp /home/app_src/.  /dest/fs/$dest_volume/_home_app_/			
    chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/_home_app_/			
    touch /dest/fs/$dest_volume/_home_app_/.persistent	
    chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/_home_app_/ /dest/fs/$dest_volume/_home_app_/.persistent	
    echo "Setup app persist" >> /client/log/fs_setup.log
  fi
fi

if test -f /client/state/flags/debug_engine_fs_setup
 then
  echo "DEBUG SLEEP"
  sleep 300
fi 

touch /client/state/flags/volume_setup_complete
echo setup complete >> /client/log/fs_setup.log
exit 0
