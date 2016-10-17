service=`cat service`

     
ts=`date +%d_%m_%y`

echo $service |\
 ssh  -o UserKnownHostsFile=/dev/null\
      -o StrictHostKeyChecking=no\
       -i /home/.ssh/run_backup_on_service\
        engines@mgmt.engines.internal\
          /opt/engines/scripts/run_backup_on_service.sh > /tmp/backup_$service/backup.${ts}.gz

      
