#!/bin/bash
PATH="/usr/local/rbenv/bin:$PATH"
export RUBY_GC_HEAP_INIT_SLOTS=1000000 # 1M
export RUBY_GC_HEAP_FREE_SLOTS=500000  # 0.5M
export RUBY_GC_HEAP_GROWTH_FACTOR=1.1
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=10000000 # 10M
export RUBY_GC_MALLOC_LIMIT_MAX=100000000    # 250M
export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1
cd /home/app/

if ! test -d /var/log/redis
 then
	mkdir /var/log/redis /var/run/redis/
fi

 if ! test -d /var/run/nginx
 then
mkdir   /var/run/nginx /var/log/nginx 
fi

 if ! test -d /var/log/nginx
 then
mkdir   /var/log/nginx 
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
 
redis-server /etc/redis/redis.conf &
redis_pid=$!

/home/deployment.sh
mkdir -p /engines/var/run/flags/


SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE

export RAILS_ENV

DATABASE_URL=$rails_flavor://$dbuser:$dbpasswd@$dbhost/$dbname
export DATABASE_URL
 if test -f /home/ruby_env
  then
	cp /home/ruby_env /home/app/.env_vars
  fi
echo " passenger_env_var RAILS_ENV $RAILS_ENV;" >> /home/app/.env_vars
echo " passenger_env_var SECRET_KEY_BASE $SECRET_KEY_BASE;" >> /home/app/.env_vars
echo " passenger_env_var SYSTEM_API_URL $SYSTEM_API_URL;">> /home/app/.env_vars
echo " passenger_env_var SYSTEM_RELEASE $SYSTEM_RELEASE;" >> /home/app/.env_vars
echo " passenger_env_var DATABASE_URL $DATABASE_URL;" >> /home/app/.env_vars
echo " passenger_env_var ACTION_CABLE_ALLOWED_REQUEST_ORIGINS $ACTION_CABLE_ALLOWED_REQUEST_ORIGINS;" >> /home/app/.env_vars
echo " passenger_env_var ACTION_CABLE_URL $ACTION_CABLE_URL;" >> /home/app/.env_vars

if test -f /home/app/env_production.rb
	then
cp	 env_production.rb /home/app/config/environments/production.rb
fi
echo migrating database 
/usr/local/rbenv/shims/bundle exec rake db:migrate 

# "SELECT EXISTS (SELECT * FROM users WHERE username='admin');"` -eq 1

/usr/local/rbenv/shims/bundle exec rake db:seed >/dev/null

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
echo Starting Server
nginx &
echo Server Started
touch  /engines/var/run/flags/startup_complete
wait 

kill -TERM $redis_pid
wait $redis_pid
rm /engines/var/run/flags/startup_complete
