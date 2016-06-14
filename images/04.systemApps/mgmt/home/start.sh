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

	
if ! test -f /home/fs/persistent/.setup	
	then
		cp -rp /home/app/public /home/fs/persistent/public
		rm -r /home/app/public
		ln -s /home/fs/persistent/public /home/app/public
		touch /home/fs/persistent/.setup	
	fi

/home/deployment.sh

export  RAILS_ENV

SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE RAILS_ENV

echo migrating database 
/usr/local/rbenv/shims/bundle exec rake db:migrate 

# "SELECT EXISTS (SELECT * FROM users WHERE username='admin');"` -eq 1

		/usr/local/rbenv/shims/bundle exec rake db:seed >/dev/null

echo building thumb nails
#bundle exec rake paperclip:refresh:thumbnails CLASS=ApplicationDisplayProperties

echo precompiling assests

/usr/local/rbenv/shims/bundle exec rake assets:precompile  >/dev/null



export RUBY_GC_HEAP_GROWTH_FACTOR=1.1

#You can also set how much memory Ruby is allowed to allocate off-heap4 before Ruby runs minor GC. You may want to lower that threshold:

export RUBY_GC_MALLOC_LIMIT=267000100
export RUBY_GC_MALLOC_LIMIT_MAX=16000100
export RUBY_GC_MALLOC_LIMIT_GROWTH_FACTOR=1.1

#Similarly, you may want to reduce how much memory Ruby allocates off-heap before it runs a full major GC:

export RUBY_GC_OLDMALLOC_LIMIT=16000100
export RUBY_GC_OLDMALLOC_LIMIT_MAX=16000100

	

if ! test -d /var/log/app
	then
		mkdir /var/log/app
	fi

 rm -rf /home/app/log 

ln -s /var/log/app /home/app/log 



PID_FILE=/var/run/apache2/apache2.pid


export PID_FILE
. /home/trap.sh



/usr/sbin/apache2ctl -DFOREGROUND &
touch  /engines/var/run/flags/startup_complete
wait 
rm $PID_FILE


rm /engines/var/run/flags/startup_complete
