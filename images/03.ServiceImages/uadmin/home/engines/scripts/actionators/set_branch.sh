#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="release"
check_required_values 

if test $release = `git branch | grep \* | cut -d ' ' -f2`
 then
  echo "Already release $release"
  exit 0
fi
git pull https://github.com/lachdoug/user_admin.git $release
get checkout $release


echo installing Gems
bundle install --standalone  
kill -TERM `cat /home/engines/run/uadmin.pid`
 