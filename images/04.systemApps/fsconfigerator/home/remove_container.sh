#!/bin/sh -x


for cmd in $*
 do
  case $cmd in
 	state)
 		rm -r /client/state/*
 		;;
 	logs)
 		rm -r /client/log/*
 		;;
 	fs)	
 	    files=`ls -a /dest/fs/ | sed "/^.$/s///" | sed "/^..$/s///"`
 	    if test -n $files
 	    	then
 	    	    cd  /dest/fs/	    
 				rm -r $files
 			fi
 		;;
 	all)
 		rm -r /client/log/*
 		rm -r /client/state/*
 		rm -r /dest/fs/*
 		;;
  esac
 done



