#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="log_name log_file_path ctype log_type"
check_required_values

log_name=`echo $log_name | sed "/ /s//_/g"`

if ! test -d /home/saved/$parent_engine/
 then
 	mkdir -p /home/saved/$parent_engine/
 fi
 
 case $log_type in
 nginx_error_log)
 log_file_path=services/wap/nginx/$parent_engine.$log_file_path
 ;;
 nginx)
 log_file_path=services/wap/nginx/$parent_engine.$log_file_path
 ;;

 syslog)
 log_file_path=services/syslog/$log_file_path
 ;;
 
 apache_error_log)
 if test -z $ctype
  then
   ctype=app
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 apache)
 if test -z $ctype
  then
   ctype=app
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 raw_dated)
 if test -z $ctype
  then
   ctype=app 
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 raw)
 if test -z $ctype
  then
   ctype=app 
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 esac
 
 if ! test -d /home/app/config.user.d/${ctype}s/$parent_engine/
  then	 
   mkdir -p /home/app/config.user.d/${ctype}s/$parent_engine/
 fi
    
 conf=/home/app/config.user.d/${ctype}s/$parent_engine/$log_name

 
echo  '{'\"$parent_engine_$log_name\": { \"display\" : \"$parent_engine $log_name\", \"path\"    : \"/var/log/engines/$log_file_path\",  > /tmp/.conf
cat  /home/engines/templates/logview/$log_type >>  /tmp/.conf
echo '}' >> /tmp/.conf
if ! test -f /var/log/engines/$log_file_path
 then
 	echo "Log does not exist"
 	mv  /tmp/.conf /tmp/$parent_engine_$log_name.rejected
 	exit
 fi
mv  /tmp/.conf $conf
#/home/engines/scripts/services/build_config.sh
 