#!/bin/sh -x
echo "Add Volume $1"  >> /client/log/fs_setup.log
if ! test -z $1
 then 
 	chown -R $fw_user /dest/fs/$1
 	chmod g+w -R  /dest/fs/$1
 fi