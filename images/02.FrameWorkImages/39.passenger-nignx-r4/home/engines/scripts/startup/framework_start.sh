#!/bin/sh

configure_passenger()
{
cp /home/ruby_env /home/.env_vars
  for env_name in `cat /home/app.env `
      do
        env_name=`eval echo '$'$env_name`
         if ! test -z  "${env_name}"
        then
            echo  "passenger_env_var $env_name \"${env_name}\";" >> /home/.env_vars
        fi
      done
echo " passenger_env_var RAILS_ENV $RAILS_ENV;" >> /home/.env_vars
echo " passenger_env_var SECRET_KEY_BASE $SECRET_KEY_BASE;" >> /home/.env_vars
}

if ! test -d /var/log/nginx
 then
  mkdir /var/log/nginx
 fi 
 if test -f /home/ruby_env
   then
     configure_passenger
  fi   
 
  nginx &
  echo -n " $!" >> $PID_FILE
