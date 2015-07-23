#!/bin/bash
PATH="/usr/local/rbenv/bin:$PATH"
if ! test -d /var/log/apache2
	then
		mkdir  /var/log/apache2
	fi
cd /home/app/

if test -f /home/app/app/config/newrelic.yml
	then
		rm /home/app/app/config/newrelic.yml
	fi
	
git fetch origin master
git reset --hard FETCH_HEAD
git pull --depth 1 origin master

#cat /home/app/Gemfile |grep -v rubyracer >/tmp/gf
#cp /tmp/gf  /home/app/Gemfile 

cp /home/newrelic.yml /home/app/

mkdir -p /engines/var/run/flags/
RAILS_ENV=production


export  RAILS_ENV

echo installing Gems
/usr/local/rbenv/shims/bundle install >/dev/null
echo migrating database 
/usr/local/rbenv/shims/bundle exec rake db:migrate 

/usr/local/rbenv/shims/bundle exec rake db:seed >/dev/null

echo precompiling assests
/usr/local/rbenv/shims/bundle exec rake assets:precompile  >/dev/null

SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE RAILS_ENV

if ! test -d /var/log/app
	then
		mkdir  /var/log/app
	fi

 rm -rf /home/app/log 

ln -s /var/log/app /home/app/log 


PID_FILE=/var/run/apache2/apache2.pid

export PID_FILE
. /home/trap.sh


/usr/sbin/apache2ctl -DFOREGROUND &
touch  /engines/var/run/flags/startup_complete
wait 

rm /var/run/apache2/apache2.pid
rm /engines/var/run/flags/startup_complete
