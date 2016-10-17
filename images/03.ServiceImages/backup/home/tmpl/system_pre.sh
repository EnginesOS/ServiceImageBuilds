
    
ts=`date +%d_%m_%y`

echo $service |\
 ssh  -o UserKnownHostsFile=/dev/null\
      -o StrictHostKeyChecking=no\
       -i /home/.ssh/run_system_backup\
        engines@mgmt.engines.internal\
          /opt/engines/scripts/services/backup/run_backup_on_service.sh > /tmp//tmp/system_backup/backup.${ts}.gz

      
