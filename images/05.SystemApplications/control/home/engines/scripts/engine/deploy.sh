#!/bin/bash

release=$RELEASE
release=master
if ! test -d /home/app
 then
	git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui /home/app/
 else
   cd /home/app
   git pull	
 fi	
cd /home/app 
echo installing Gems
bundle install --standalone   

