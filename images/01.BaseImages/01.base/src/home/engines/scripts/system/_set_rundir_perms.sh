#!/bin/sh

chown -R $ContUser.containers /home/engines/run
if ! test -d ~/.ssh
 then 
  mkdir ~/.ssh
fi
chown -R $ContUser ~/.ssh
chmod 700 ~/.ssh
