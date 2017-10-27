#!/bin/bash


cd /home/app/

if ! test -f /home/app/app/config/mail.yml
 then
	cat /home/tmpls/mail.yml.tmpl | sed "s/FQDN_PORT/$FQDN_PORT/" | sed "s/DOMAIN/$DOMAIN/" > /home/app/app/config/mail.yml
fi
	 

 if ! test -d /var/run/nginx
 then
  mkdir /var/run/nginx /var/log/nginx 
fi

 if ! test -d /var/log/nginx
 then
	mkdir /var/log/nginx 
fi

if test -f /home/app/app/config/newrelic.yml
	then
		rm /home/app/app/config/newrelic.yml
	fi
	
if ! test -f /home/fs/persistent/.setup	
	then
		cp -rp /home/app/public/system /home/fs/persistent/
		rm -r /home/app/public/system
		ln -s /home/fs/persistent/system /home/app/public/system
		touch /home/fs/persistent/.setup	
	fi
if ! test -h /home/app/public/system
 then
 	rm -r /home/app/public/system
	ln -s /home/fs/persistent/system /home/app/public/system
 fi
 

/home/deployment.sh


SECRET_KEY_BASE=`bundle exec rake secret`
export SECRET_KEY_BASE

export RAILS_ENV

mkdir -p /home/fs/persistent/db/

if ! test -f /home/fs/persistent/db/database.sqllite
  then
	touch /home/fs/persistent/db/database.sqllite
fi

#DATABASE_URL=$rails_flavor://$dbuser:$dbpasswd@$dbhost/$dbname
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

#if test -f /home/app/env_production.rb
	#then
#cp	 env_production.rb /home/app/config/environments/production.rb
#fi
echo migrating database 
bundle exec rake db:migrate 

# "SELECT EXISTS (SELECT * FROM users WHERE username='admin');"` -eq 1

bundle exec rake db:seed >/dev/null

echo precompiling assests

bundle exec rake assets:precompile  >/dev/null

if ! test -d /var/log/app
  then
	mkdir /var/log/app
fi

rm -rf /home/app/log 

ln -s /var/log/app /home/app/log 


PID_FILE=/var/run/nginx/nginx.pid

export PID_FILE
. /home/engines/functions/trap.sh
echo Starting Server
nginx &
echo Server Started
touch  /home/engines/run/flags/startup_complete
wait 
exit_code=$?


rm /home/engines/run/flags/startup_complete
exit $exit_code
