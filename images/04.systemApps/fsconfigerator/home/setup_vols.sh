#/bin/sh -x

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
chown $fw_user -R /client/state/run


if test -f /dest/fs/.persistant
 then
  chown -R $fw_user /dest/fs/
else
  dirs=`ls /home/fs_src/ | egrep -v "local"`
	for dir in $dirs
		do
			cp -r  /home/fs_src/$dir/* /dest/fs/	
			
		done
	#if no presistance dirs/files need to set permission here
	
	chown -R ${fw_user}.${data_gid}  /dest/fs/
	chmod g+w -R /dest/fs/
	
	touch /dest/fs/.persistant
fi

touch /client/state/flags/volume_setup_complete

