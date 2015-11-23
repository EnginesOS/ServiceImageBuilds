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

if  test -f /home/app/Gemfile	
	then
	mv /home/app/Gemfile  /tmp/gf
	fi
	
	echo -n  `grep mgmt /etc/hosts|awk '{print $1}' |cut -d. -f-3`.1 > /opt/engines/etc/net/management
	
release=`cat /opt/engines/release`
git fetch origin $release
git reset --hard FETCH_HEAD
git pull --depth 1 origin  $release
git branch  $release
if ! test -f /home/app/Gemfile
 then
   cp /tmp/gf /home/app/Gemfile
 else
	cat /home/app/Gemfile |grep -v rubyracer >/tmp/gf
	cp /tmp/gf  /home/app/Gemfile
fi 

cp /home/newrelic.yml /home/app/

mkdir -p /engines/var/run/flags/
RAILS_ENV=production


export  RAILS_ENV

echo installing Gems
/usr/local/rbenv/shims/bundle install --standalone 
echo migrating database 
/usr/local/rbenv/shims/bundle exec rake db:migrate 
if ! test `sqlite3 /home/app/db/production.sqlite3 "SELECT EXISTS (SELECT * FROM users WHERE username='admin');"` -eq 1
	then
		/usr/local/rbenv/shims/bundle exec rake db:seed >/dev/null
fi
echo building thumb 
nails
bundle exec rake paperclip:refresh:thumbnails CLASS=ApplicationDisplayProperties

echo precompiling assests

/usr/local/rbenv/shims/bundle exec rake assets:precompile  >/dev/null

SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE RAILS_ENV

if ! test -d /var/log/app
	then
		mkdir /var/log/app
	fi

 rm -rf /home/app/log 

ln -s /var/log/app /home/app/log 


PID_FILE=/var/run/apache2/apache2.pid

export PID_FILE
. /home/trap.sh

/home/clear_flags.sh

/usr/sbin/apache2ctl -DFOREGROUND &
touch  /engines/var/run/flags/startup_complete
wait 

rm /var/run/apache2/apache2.pid
rm /engines/var/run/flags/startup_complete
