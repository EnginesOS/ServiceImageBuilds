#!/bin/sh


 . /home/engines/functions/checks.sh

required_values="log_name log_file_path container_type log_type"
check_required_values

log_name=`echo $log_name | sed "/ /s//_/g"`
config_file=/home/app/config.user.d/${container_type}s/$parent_engine/$log_name.json



if ! test -d /home/saved/$parent_engine/
 then
 	mkdir -p /home/saved/$parent_engine/
 	echo $log_type $log_file_path  $container_type $parent_engine $log_name > /home/saved/$parent_engine/lf.$log_name
 fi
 
 case $log_type in
 nginx_error_log)
 log_file_path=services/wap/nginx/$parent_engine.$log_file_path
 ;;
 nginx)
 log_file_path=services/wap/nginx/$parent_engine.$log_file_path
 ;;

 syslog)
 log_file_path=/services/syslog/$log_file_path
 ;;
 
 apache_error_log)
 if test -z $container_type
  then
   container_type=app
  fi
 log_file_path=${container_type}s/$parent_engine/$log_file_path
 ;;
 apache)
 if test -z $container_type
  then
   container_type=app
  fi
 log_file_path=${container_type}s/$parent_engine/$log_file_path
 ;;
 
 raw_dated)
 if test -z $container_type
  then
   container_type=app 
  fi
 log_file_path=${container_type}s/$parent_engine/$log_file_path
 ;;
 
 raw)
 if test -z $container_type
  then
   container_type=app 
  fi
 log_file_path=${container_type}s/$parent_engine/$log_file_path
 ;;
 
 esac
 
 if ! test -d /home/app/config.user.d/${container_type}s/$parent_engine/
  then	 
   mkdir -p /home/app/config.user.d/${container_type}s/$parent_engine/
 fi
    
 

 
echo  '{"'$parent_engine_$log_name'": { "display" : "'$parent_engine $log_name'", "path":"/var/log/engines/'$log_file_path'",'  > /tmp/.conf
cat  /home/engines/templates/logview/$log_type >>  /tmp/.conf
echo '}' >> /tmp/.conf

if ! test -f /var/log/engines/$log_file_path
 then
 	echo "Log /var/log/engines/$log_file_path does not exist"
 	mv  /tmp/.conf /tmp/$parent_engine_$log_name.rejected_no_such_log
 	exit
 fi
mv  /tmp/.conf $config_file
#/home/engines/scripts/services/build_config.sh
 