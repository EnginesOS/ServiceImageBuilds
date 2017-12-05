#!/bin/bash

release=$RELEASE
release=master
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

