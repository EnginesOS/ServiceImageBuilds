
    
ts=`date +%d_%m_%y`
mkdir -p /tmp/system_backup

  curl -k https://172.17.0.1:2380/v0/backup/system_files  >/tmp/system_backup/files_$ts
  curl -k https://172.17.0.1:2380/v0/backup/system_db  >/tmp/system_backup/db_$ts
 # curl -k https://172.17.0.1:2380/v0/backup/registry  >/tmp/system_backup/system_registry_$ts
exit 0

  