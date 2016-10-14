#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env


log_name=`echo $log_name | sed "/ /s//_/g"`

if ! test -d /home/saved/$parent_engine/
 then
 	mkdir -p /home/saved/$parent_engine/
 fi
 
 case $log_type in
 nginx_error_log)
 log_file_path=services/nginx/nginx/$parent_engine.$log_file_path
 ;;
 nginx)
 log_file_path=services/nginx/nginx/$parent_engine.$log_file_path
 ;;

 syslog)
 log_file_path=syslog/$log_file_path
 ;;
 
 apache_error_log)
 if test -z $ctype
  then
   ctype=container
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 apache)
 if test -z $ctype
  then
   ctype=container
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 raw_dated)
 if test -z $ctype
  then
   ctype=engine 
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 raw)
 if test -z $ctype
  then
   ctype=engine 
  fi
 log_file_path=${ctype}s/$parent_engine/$log_file_path
 ;;
 
 esac
 
 conf=/home/saved/$parent_engine/$log_name

 
echo  \"$parent_engine_$log_name\": { \"display\" : \"$parent_engine $log_name\", \"path\"    : \"/var/log/engines/$log_file_path\",  > /tmp/.conf
cat  /home/tmpls/$log_type >>  /tmp/.conf
if ! test -f /var/log/engines/$log_file_path
 then
 	echo "Log does not exist"
 	mv  /tmp/.conf /tmp/$parent_engine_$log_name.rejected
 	exit
 fi
mv  /tmp/.conf $conf
/home/build_config.sh
 