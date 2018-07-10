#!/bin/bash

release=$RELEASE
if test -z $release
 then
 if test -f /home/app/release
  then
      release=`cat /home/app/release`
   else
	release=master
  fi	
fi	
cd /home/app/

if ! test -d /home/app/control
 then
 	pwd
 	ls -la /home/app
 	whoami
    echo git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui control
	git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui control
 else
   cd /home/app/control
   git pull	
fi	
 
cd /home/app/control
mkdir -p /home/app/control/data 
mkdir -p /home/app/control/public  

echo installing Gems
export RACK_ENV production
bundle install --standalone   

