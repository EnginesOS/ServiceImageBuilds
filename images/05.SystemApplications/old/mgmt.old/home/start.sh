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
	


export RUBY_GC_HEAP_GROWTH_FACTOR=1.1

#You can also set how much memory Ruby is allowed to allocate off-heap4 before Ruby runs minor GC. You may want to lower that threshold:

export RUBY_GC_MALLOC_LIMIT=4000100
export RUBY_GC_MALLOC_LIMIT_MAX=16000100
export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

#Similarly, you may want to reduce how much memory Ruby allocates off-heap before it runs a full major GC:

export RUBY_GC_OLDMALLOC_LIMIT=16000100
export RUBY_GC_OLDMALLOC_LIMIT_MAX=16000100

	
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

mkdir -p /home/engines/run/flags/
RAILS_ENV=production

sudo -n /home/_start_sshd.sh &
sshd_pid=$!

export  RAILS_ENV

echo installing Gems
/usr/local/rbenv/shims/bundle install --standalone 
echo migrating database 
/usr/local/rbenv/shims/bundle exec rake db:migrate 
if ! test `sqlite3 /home/app/db/production.sqlite3 "SELECT EXISTS (SELECT * FROM users WHERE username='admin');"` -eq 1
	then
		/usr/local/rbenv/shims/bundle exec rake db:seed >/dev/null
fi
echo building thumb nails
bundle exec rake paperclip:refresh:thumbnails CLASS=ApplicationDisplayProperties

echo precompiling assests

/usr/local/rbenv/shims/bundle exec rake assets:precompile  >/dev/null

SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE RAILS_ENV

if ! test -d /var/log/app
	then
		mkdir /var/log/app
	fi

 rm -rf /home/engines/var/log/ 

ln -s /var/log/app /home/engines/var/log/ 



PID_FILE=/var/run/engines/pids


export PID_FILE
. /home/engines/functions/trap.sh

/home/clear_flags.sh

/usr/sbin/apache2ctl -DFOREGROUND &
apache_pid=`cat /var/run/apache2/apache2.pid`
sshd_pid=`cat /var/run/sshd.pid`

echo -n "$apache_pid $sshd_pid" > /var/run/engines/pids
touch  /home/engines/run/flags/startup_complete
wait 
rm $PID_FILE


rm /home/engines/run/flags/startup_complete
