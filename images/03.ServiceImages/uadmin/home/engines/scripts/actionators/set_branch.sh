#!/bin/sh

 . /home/engines/functions/checks.sh
 
cd /home/app

required_values="branch"
check_required_values 

if test $branch = `git branch | grep \* | cut -d ' ' -f2`
 then
  echo "Already release $branch"
  exit 0
fi
git pull https://github.com/lachdoug/user_admin.git $branch
git checkout $branch

export RACK_ENV production

echo installing Gems
bundle install --standalone  
kill -TERM `cat /home/engines/run/uadmin.pid`
 