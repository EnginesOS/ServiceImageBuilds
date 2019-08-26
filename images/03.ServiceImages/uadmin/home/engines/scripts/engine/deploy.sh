#!/bin/sh
cd /home/app
git pull
export RACK_ENV production
bundle install --standalone   

if test -f /home/app/config/database.yml
 then
  echo "#Generated by Engines builder
  production:
   adapter: $rails_flavor
   database: $dbname 
   host: $dbhost
   username: $dbuser
   password: $dbpasswd
  " > /home/app/config/database.yml
fi
 