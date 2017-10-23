


service=`echo $CONFDIR | awk -F/ '{print $NF}'` 
rm -r /tmp/backup_$service

   