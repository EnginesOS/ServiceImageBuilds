#!/bin/bash
PATH="/usr/local/rbenv/bin:$PATH"
mkdir /var/log/apache2
cd /home/app/
rm /home/app/app/config/newrelic.yml
git fetch origin master
git reset --hard FETCH_HEAD
git pull --depth 1 origin master

cat /home/app/Gemfile |grep -v rubyracer >/tmp/gf
cp /tmp/gf  /home/app/Gemfile 

cp /home/newrelic.yml /home/app/

mkdir -p /engines/var/run/flags/
RAILS_ENV=production


export  RAILS_ENV

/usr/local/rbenv/shims/bundle install

/usr/local/rbenv/shims/bundle exec rake db:migrate

/usr/local/rbenv/shims/bundle exec rake db:seed

/usr/local/rbenv/shims/bundle exec rake assets:precompile

SECRET_KEY_BASE=`/usr/local/rbenv/shims/bundle exec rake secret`
export SECRET_KEY_BASE RAILS_ENV

cp -rp /home/app/log /var/log/app

rm -rf  /home/app/log 

ln -s /var/log/app /home/app/log 




PID_FILE=/var/run/apache2/apache2.pid

export PID_FILE
. /home/trap.sh


/usr/sbin/apache2ctl -DFOREGROUND &
touch  /engines/var/run/flags/startup_complete
wait 

rm /var/run/apache2/apache2.pid
rm /engines/var/run/flags/startup_complete
