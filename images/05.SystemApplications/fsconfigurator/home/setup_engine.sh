#!/bin/sh -x
echo Setup Engine user $fw_user
#VOLUME /client/log
#VOLUME /client/log
#VOLUME /client/state
#VOLUME /home/fs
#VOLUME /dest/fs

set

logs=`ls /var/log/`

for log in $logs
 do
  cp -rp /var/log/$log  /client/log/  >> /client/log/fs_setup.err 2>&1
done 

chown $fw_user -R /client/log/  >> /client/log/fs_setup.err 2>&1
chown $fw_user -R /client/log  >> /client/log/fs_setup.err 2>&1
mkdir -p /client/state/flags  >> /client/log/fs_setup.err 2>&1
chown $fw_user -R /client/state  >> /client/log/fs_setup.err 2>&1
touch client/state/flags/fsconfigurated  >> /client/log/fs_setup.err 2>&1
chgrp 22020  -R /client/state  >> /client/log/fs_setup.err 2>&1
chmod g+w -R /client/state  >> /client/log/fs_setup.err 2>&1


cd /home/fs_src/
if test `ls volumes |wc -l` -ne 0
 then
echo vol_dir_maps  >> /client/log/fs_setup.log 
cat /home/fs_src/vol_dir_maps  >> /client/log/fs_setup.log  
 for dir in `cat /home/fs_src/vol_dir_maps`
  do
   dest_volume=`grep "$dir " /home/fs_src/vol_dir_maps | awk '{print $2}'`  >> /client/log/fs_setup.err 2>&1
   echo move $dir to $dest_volume >> /client/log/fs_setup.log  >> /client/log/fs_setup.log
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
  	    mkdir -p /dest/fs/$dest_volume/`dirname $dir`  >> /client/log/fs_setup.err 2>&1 
  	    echo	mkdir -p /dest/fs/$dest_volume/`dirname $dir`>> /client/log/fs_setup.log 
  	    chown  ${fw_user}.${data_gid}  /dest/fs/$dest_volume/`dirname $dir`  >> /client/log/fs_setup.err 2>&1
  	  fi
  	
  	 echo cp -nrp /home/fs_src/$dir /dest/fs/$dest_volume/$dir>> /client/log/fs_setup.log
   	 cp -nrp /home/fs_src/$dir /dest/fs/$dest_volume/$dir  >> /client/log/fs_setup.err 2>&1 
   	 chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/$dir  >> /client/log/fs_setup.err 2>&1
   	 echo chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/$dir>> /client/log/fs_setup.log
   fi
 done
 echo volume maps  >> /client/log/fs_setup.log
 cat /home/fs_src/vol_file_maps  >> /client/log/fs_setup.log  >> /client/log/fs_setup.err 2>&1
 for file in `cat /home/fs_src/vol_file_maps`
  do	 
   dest_volume=`grep "$file " /home/fs_src/vol_file_maps | awk '{print $2}'`	  >> /client/log/fs_setup.err 2>&1
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
  	   mkdir -p /dest/fs/$dest_volume/`dirname $file`  >> /client/log/fs_setup.err 2>&1
  	   chown ${fw_user}.${data_gid}  /dest/fs/$dest_volume/`dirname $file`  >> /client/log/fs_setup.err 2>&1
     fi
  	 
   echo cp -np /home/fs_src/$file /dest/fs/$dest_volume/$file  >> /client/log/fs_setup.log
   cp -np /home/fs_src/$file /dest/fs/$dest_volume/$file  >> /client/log/fs_setup.err 2>&1
   chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/$file  >> /client/log/fs_setup.err 2>&1
  fi
 done
	 
echo volumes  >> /client/log/fs_setup.log
ls /home/fs_src/volumes  >> /client/log/fs_setup.err 2>&1
  for vol in `ls /home/fs_src/volumes`
   do  
   echo /dest/fs/$vol/  >> /client/log/fs_setup.log
    touch /dest/fs/$vol/.persistent_lock  >> /client/log/fs_setup.err 2>&1 
    chown  ${fw_user}.${data_gid} /dest/fs/$vol/ /dest/fs/$vol/.persistent_lock  >> /client/log/fs_setup.err 2>&1
    chmod o-rxw /dest/fs/$vol/   >> /client/log/fs_setup.err 2>&1
    chmod g+sw -R /dest/fs/$vol/   >> /client/log/fs_setup.err 2>&1
   done
	
 if test -d /home/app_src
  then
   dest_volume=`grep "/home/app " /home/fs_src/vol_dir_maps | awk '{print $2}'`
    if ! test -f /dest/fs/$dest_volume/_home_app_/.persistent	
    then
     cp -rp /home/app_src/.  /dest/fs/$dest_volume/_home_app_/			 >> /client/log/fs_setup.err 2>&1 
     chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/_home_app_/			 >> /client/log/fs_setup.err 2>&1
     touch /dest/fs/$dest_volume/_home_app_/.persistent	  >> /client/log/fs_setup.err 2>&1
     chown -R ${fw_user}.${data_gid}  /dest/fs/$dest_volume/_home_app_/ /dest/fs/$dest_volume/_home_app_/.persistent	 >> /client/log/fs_setup.err 2>&1
     echo "Setup app persist" >> /client/log/fs_setup.log 
   fi
 fi
fi 

if test -f /client/state/flags/debug_engine_fs_setup
 then
  echo "DEBUG SLEEP"
  sleep 300
fi 

touch /client/state/flags/volume_setup_complete  >> /client/log/fs_setup.err 2>&1
echo setup complete >> /client/log/fs_setup.log
exit 0
