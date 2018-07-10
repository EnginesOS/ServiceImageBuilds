#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

cd /home/app

required_values="branch"
check_required_values 

if test $release=`git branch | grep \* | cut -d ' ' -f2`
 then
  echo "Already release $branch"
  exit 0
fi
git pull https://github.com/lachdoug/user_admin.git $branch
get checkout $branch

export RACK_ENV production

echo installing Gems
bundle install --standalone  
kill -TERM `cat /home/engines/run/uadmin.pid`
 