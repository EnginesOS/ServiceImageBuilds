#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

if test -z $section 
 then
  section=''
elif test "$section" = all
 then
  section=''
 fi  
 
if test -z $replace
 then
  replace=replace #replace|rename|missing
fi
export replace section source


CURL_OPTS="-k -X PUT --header "Content-Type:application/octet-stream" --data-binary  @-"

function restore_system {
echo "Restoring system $replace $source $section $from_date"
/home/engines/scripts/engine/run_duply.sh system restore /tmp/system/ $from_date

sudo -n -E /home/engines/scripts/restore/_restore_system.sh

#cat /tmp/system/db*gz |curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/system/db
#sudo -n /home/engines/scripts/restore/_clr_restore.sh system
}

function restore_registry {
/home/engines/scripts/engine/run_duply.sh registry restore /tmp/registry $from_date
sudo -n -E /home/engines/scripts/restore/_restore_registry.sh
}

function restore_logs {

if ! test -z $section
 then
   path=$path/$section
fi

if test -z $path
 then
  /home/engines/scripts/engine/run_duply.sh logs restore /tmp/logs $from_date
   echo "Restoring full logs $replace"
  sudo -n -E /home/engines/scripts/restore/_restore.sh $replace logs
  sudo -n /home/engines/scripts/restore/_clr_restore.sh logs
else
 /home/engines/scripts/engine/run_duply.sh logs fetch $path /tmp/logs 
  echo "Restoring logs $path $replace"
  sudo -n -E /home/engines/scripts/restore/_restore.sh $replace logs
  sudo -n /home/engines/scripts/restore/_clr_restore.sh logs
fi
}

function volume_restore {


path=$source
if ! test -z $section
 then
  path=$path/$section
fi

if test -z $path
 then
 echo "Restoring engines_fs full $replace"
 /home/engines/scripts/engine/run_duply.sh engines_fs restore /tmp/volumes/fs/ $from_date
else
 echo "Restoring engines_fs $path"
 /home/engines/scripts/engine/run_duply.sh engines_fs fetch $path /tmp/volumes/fs/$path $from_date
fi
  
 sudo -n -E /home/engines/scripts/restore/_restore.sh $replace volumes/fs
 sudo -n /home/engines/scripts/restore/_clr_restore.sh volumes
  
}

function service_restore {
echo "Restoring $service $replace $section"
/home/engines/scripts/engine/run_duply.sh $service restore /tmp/$service $from_date
 

sudo -n /home/engines/scripts/restore/_bundle_restore.sh $service |curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/service/$service/$replace/$section 
sudo -n /home/engines/scripts/restore/_clr_restore.sh $service
}

function restore_engines {

 curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/engines
}

function restore_services {
for service in syslog mongo_server mysql_server pgsql_server auth cert_auth email imap 
 do
   service_restore
done
}

function restore_engine_services {
echo ""
}

echo  $type > /engines/var/run/flags/restore

if test $type = full
 then
  restore_logs
  volume_restore
  restore_system  
  restore_services
  restore_registry 
  restore_engines 
elif test $type = system
 then
  restore_system 
elif test $type = registry
 then
  restore_registry 
elif test $type = logs
 then
  restore_logs
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
elif test $type = engine
 then
  if test -z $source
   then
    echo "missing engine name"
    exit 127
   fi
  restore_system  
  volume_restore
  restore_engine_services
  restore_engine
else
 echo "Unknown Restore Type"
 exit 255   
fi

rm /engines/var/run/flags/restore
exit 0
