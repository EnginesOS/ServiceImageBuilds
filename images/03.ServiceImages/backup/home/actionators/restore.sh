#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

function restore_system {

duply system restore /tmp/system $from_date
if test -z $section
 then
  section=all
fi  
tar -czpf - /tmp/system |curl  -k -X PUT --header "Content-Type:application/octet-stream" --data-binary  @- https://172.17.0.1:2380/v0/restore/system/$section
rm -r /tmp/system

}

function restore_registry {

duply system restore /tmp/system $from_date
if test -z $section
 then
  section=all
fi  
tar -czpf - /tmp/system/*registry* |curl  -k -X PUT --header "Content-Type:application/octet-stream" --data-binary  @- https://172.17.0.1:2380/v0/restore/registry
rm -r /tmp/system/*registry*

}

function logs_restore {
if $section == all
 then
  $section=''
 fi
  
  duply logs restore /tmp/logs
  cp -rp /tmp/logs/$source/$section /backup_src/logs/$source/$section
  rm -r /tmp/logs
}
function volume_restore {
if $section == all
 then
  $section=''
 fi
  
  duply engines_files restore /tmp/engines_files
  cp -rp /tmp/engines_files/$source/$section /backup_src/volumes/fs/$source/$section
  rm -r /tmp/engines_files
}

function service_restore {
duply $service restore /tmp/$service $from_date
if test -z $section
 then
  section=all
fi  
tar -czpf - /tmp/$service |curl  -k -X PUT --header "Content-Type:application/octet-stream" --data-binary  @- https://172.17.0.1:2380/v0/restore/service/$service/$section 
rm -r /tmp/$service


}
function restore_services {
for service in mongo_server mysql_server pgsql_server auth cert_auth email imap
      do
       service_restore
     done
}

if test $type = all
 then
	restore_registry 
	restore_system  
	volume_restore
	logs_restore
	restore_services
elif test $type = system
  then
	restore_system 
elif test $type = registry
   then
	restore_registry 
elif test $type = volume 
 then
   volume_restore
elif test $type = service
then
	if test -z $source
	 then
	  restore_services
    else
     service=$source
     service_restore
    fi
fi



exit 0
