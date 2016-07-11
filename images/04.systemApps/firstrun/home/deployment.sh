#!/bin/bash
cd /home/app
#release=$RELEASE
release=master
git fetch origin $release
git reset --hard FETCH_HEAD
git pull --depth 1 origin  $release

if ! test -f /home/app/Gemfile
 then
   cp /tmp/gf /home/app/Gemfile
 else
	cat /home/app/Gemfile |grep -v rubyracer >/tmp/gf
	cp /tmp/gf  /home/app/Gemfile
fi 

cp /home/newrelic.yml /home/app/


RAILS_ENV=production

echo installing Gems
grep thin /home/app/Gemfile >/dev/null
if test $? -ne 0
 then
  echo "gem 'thin'" >> home/app/Gemfile
fi
/usr/local/rbenv/shims/bundle install --standalone 

