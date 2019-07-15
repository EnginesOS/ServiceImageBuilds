

service=`echo $CONFDIR | awk -F/ '{print $NF}'` 
if ! test -d /tmp/backup_SERVICE
 then
   mkdir /tmp/backup_SERVICE
fi   

ts=`date +%d_%m_%y`
curl -k https://172.17.0.1:2380/v0/backup/service/SERVICE > /tmp/backup_SERVICE/backup.${ts}
exit 0


      
