
add_service()
{
src=/tmp/backup_$service/

mkdir -p ${Backup_ConfigDir}/${service}
chmod og-rx $Backup_ConfigDir/$service
echo -n $service >$Backup_ConfigDir/$service/service
cp /home/engines/templates/backup/service_pre.sh $Backup_ConfigDir/$service/pre
cp /home/engines/templates/backup/service_post.sh  $Backup_ConfigDir/$service/post
chmod u+x $Backup_ConfigDir/$service/pre
chmod u+x $Backup_ConfigDir/$service/post
/home/engines/scripts/engine/prep_conf.sh $Backup_ConfigDir/$service/conf

echo "SOURCE='$src'" >>$Backup_ConfigDir/$service/conf
_dest=$dest/$service
echo "TARGET='$_dest'" >>$Backup_ConfigDir/$service/conf
echo "TARGET_USER='$user'"  >>$Backup_ConfigDir/$service/conf
echo "TARGET_PASS='$pass'"  >>$Backup_ConfigDir/$service/conf
}

save_system_settings()
{
 if ! test -d /home/engines/scripts/configurators/saved/system_backup
  then
	mkdir -p /home/engines/scripts/configurators/saved/system_backup
 fi	
 echo "include_logs=$include_logs 
	  include_files=$include_files
	  include_services=$include_services
	  include_system=$include_system
	  frequency=$frequency 	" > /home/engines/scripts/configurators/saved/system_backup/settings
}