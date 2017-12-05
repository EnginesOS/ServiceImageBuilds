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

if ! test -d /home/app/control
 then
    echo git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui /home/app/control
	git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui control
 else
   cd /home/app/control
   git pull	
fi	
 
cd /home/app/control
mkdir -p /home/app/control/data 
mkdir -p /home/app/control/public  

echo installing Gems
bundle install --standalone   

