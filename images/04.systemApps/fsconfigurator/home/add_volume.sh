#!/bin/sh -x
if ! test -z $1
 then 
 	chown -R $fw_user /dest/fs/$1
 	chmod g+w -R  /dest/fs/$1
 fi