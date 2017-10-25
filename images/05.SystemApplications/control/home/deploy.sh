#!/bin/bash
cd /home/app
release=$RELEASE
release=master

git clone --depth 1 --branch $release https://github.com/lachdoug/admin_gui /home/app/
cd /home/app 
echo installing Gems
bundle install --standalone   

