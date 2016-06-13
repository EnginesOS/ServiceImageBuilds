#!/bin/bash
release=$SYSTEM_RELEASE
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





echo installing Gems
/usr/local/rbenv/shims/bundle install --standalone 

