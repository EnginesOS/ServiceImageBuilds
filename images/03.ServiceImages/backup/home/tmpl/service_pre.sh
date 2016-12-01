

service=`echo $CONFDIR | awk -F/ '{print $NF}'` 
mkdir /tmp/backup_$service

ts=`date +%d_%m_%y`
curl http://172.17.0.1:2380/v0/backup/service/$service > /tmp/backup_$service/backup.${ts}.gz


      
