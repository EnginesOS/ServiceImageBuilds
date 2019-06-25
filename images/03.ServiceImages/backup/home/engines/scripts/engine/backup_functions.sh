
set_dest_uri()
{
if test $dest_proto = "local"
 then
  dest_uri=file:///var/lib/engines/local_backup_dests/$dest_folder/$backup_id         
elif test $dest_proto = "s3"	
 then
  dest_uri="s3+http://" 
else
  dest_uri="$dest_proto://$dest_address/$dest_folder"
fi

if test $dest_proto = sftp -o $dest_proto = scp
 then
   if ! test -z $key_name
    then
     echo -n $key_name > $Backup_ConfigDir/$backup_id/key_name
   elif test -f $Backup_ConfigDir/$backup_id/key_name
    then
     rm $Backup_ConfigDir/$backup_id/key_name
  fi
fi 
  
}

write_duply_config()
{
/home/engines/scripts/engine/prep_conf.sh $Backup_ConfigDir/$backup_id/conf
set_dest_uri
echo "SOURCE=$src" >>$Backup_ConfigDir/$backup_id/conf
echo "TARGET=$dest_uri" >>$Backup_ConfigDir/$backup_id/conf
echo "TARGET_USER=$dest_user"  >>$Backup_ConfigDir/$backup_id/conf
echo "TARGET_PASS=$dest_pass"  >>$Backup_ConfigDir/$backup_id/conf

}

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

dest=$dest/$service
backup_id=$service
write_duply_config
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


