#!/bin/bash
PATH="/usr/local/rbenv/bin:$PATH"

cd /home/app/

if test -f /home/app/app/config/newrelic.yml
	then
		rm /home/app/app/config/newrelic.yml
	fi

	
if ! test -f /home/fs/persistent/.setup	
	then
		cp -rp /home/app/public /home/fs/persistent/public
		rm -r /home/app/public
		ln -s /home/fs/persistent/public /home/app/public
		touch /home/fs/persistent/.setup	
	fi

/home/deployment.sh
mkdir -p /engines/var/run/flags/


SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE
export RAILS_ENV
DATABASE_URL=$rails_flavor://$dbuser:$dbpasswd@$dbhost/$dbname
export DATABASE_URL
echo " passenger_env_var RAILS_ENV $RAILS_ENV;" > /home/app/.env_vars
echo " passenger_env_var SECRET_KEY_BASE $SECRET_KEY_BASE;" >> /home/app/.env_vars
echo " passenger_env_var SYSTEM_API_URL $SYSTEM_API_URL;">> /home/app/.env_vars
echo " passenger_env_var SYSTEM_RELEASE $SYSTEM_RELEASE;" >> /home/app/.env_vars
echo " passenger_env_var DATABASE_URL $DATABASE_URL;" >> /home/app/.env_vars

echo migrating database 
/usr/local/rbenv/shims/bundle exec rake db:migrate 

# "SELECT EXISTS (SELECT * FROM users WHERE username='admin');"` -eq 1

		/usr/local/rbenv/shims/bundle exec rake db:seed >/dev/null

echo building thumb nails
#bundle exec rake paperclip:refresh:thumbnails CLASS=ApplicationDisplayProperties

echo precompiling assests

/usr/local/rbenv/shims/bundle exec rake assets:precompile  >/dev/null

if ! test -d /var/log/app
	then
		mkdir /var/log/app
	fi

 rm -rf /home/app/log 

ln -s /var/log/app /home/app/log 


PID_FILE=/var/run/nginx/nginx.pid

export PID_FILE
. /home/trap.sh

nginx &
touch  /engines/var/run/flags/startup_complete
wait 
rm $PID_FILE

rm /engines/var/run/flags/startup_complete
