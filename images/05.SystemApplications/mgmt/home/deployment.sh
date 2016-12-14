#!/bin/bash
cd /home/app
#release=$RELEASE
release=master
git fetch origin $release
git reset --hard FETCH_HEAD
git pull --depth 1 origin  $release


cp /home/newrelic.yml /home/app/


RAILS_ENV=production

echo installing Gems
bundle install --standalone   

