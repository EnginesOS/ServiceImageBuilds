#!/bin/bash
cd /home/app
release=$RELEASE
#release=master
git fetch origin $release
git reset --hard FETCH_HEAD
git pull --depth 1 origin  $release

if ! test -f /home/app/app/config/mail.yml
 then
	cat /home/engines/templates/mail.yml.tmpl | sed "s/FQDN_PORT/$FQDN_PORT/" | sed "s/DOMAIN/$DOMAIN/" > /home/app/app/config/mail.yml
fi

cp /home/newrelic.yml /home/app/


RAILS_ENV=production

echo installing Gems
bundle install --standalone   

