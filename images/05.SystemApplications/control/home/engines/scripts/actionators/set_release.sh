#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="release"
check_required_values 

if test -d /home/app
 then
  rm -rf /home/app/control
 fi 

if ! test -d /home/app/control
 then
	git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui /home/app/control
 else
   cd /home/app/control
   git pull	
 fi	
cd /home/app/control
echo installing Gems
bundle install --standalone   