#!/bin/bash

cd /home/app/

/home/engines/scripts/engine/deployment.sh

SECRET_KEY_BASE=`bundle exec rake secret`
export SECRET_KEY_BASE
export RAILS_ENV
DATABASE_URL=sqlite3:/home/fs/persistent/db/database.sqllite
export DATABASE_URL

if test -f /home/ruby_env
  then
	cp /home/ruby_env /home/app/.env_vars
fi

echo " passenger_env_var RAILS_ENV $RAILS_ENV;" >> /home/app/.env_vars
echo " passenger_env_var PATH $PATH;" >> /home/app/.env_vars
echo " passenger_env_var SECRET_KEY_BASE $SECRET_KEY_BASE;" >> /home/app/.env_vars
echo " passenger_env_var SYSTEM_API_URL $SYSTEM_API_URL;">> /home/app/.env_vars
echo " passenger_env_var SYSTEM_RELEASE $SYSTEM_RELEASE;" >> /home/app/.env_vars
echo " passenger_env_var DATABASE_URL $DATABASE_URL;" >> /home/app/.env_vars
echo " passenger_env_var ACTION_CABLE_ALLOWED_REQUEST_ORIGINS $ACTION_CABLE_ALLOWED_REQUEST_ORIGINS;" >> /home/app/.env_vars
echo " passenger_env_var ACTION_CABLE_URL $ACTION_CABLE_URL;" >> /home/app/.env_vars
echo " passenger_env_var REDIS_URL redis://$redis_password@$redis_hostname:$redis_port/;" >> /home/app/.env_vars


echo migrating database 
bundle exec rake db:migrate 

# "SELECT EXISTS (SELECT * FROM users WHERE username='admin');"` -eq 1


echo precompiling assests

bundle exec rake assets:precompile  >/dev/null


PID_FILE=/var/run/nginx/nginx.pid

export PID_FILE
. /home/engines/functions/trap.sh
service_first_run_check

echo Starting Server
nginx &
echo Server Started
touch  /home/engines/run/flags/startup_complete
wait 
exit_code=$?
sleep 500

rm /home/engines/run/flags/startup_complete
exit $exit_code
