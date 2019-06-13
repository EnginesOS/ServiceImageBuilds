#!/bin/sh

echo "Remove dir $1 "  >> /client/log/fs_setup.log

dir=$1
 files=`ls -a $dir | sed "/^.$/s///" | sed "/^..$/s///"`
 if test -n "$files"
 	then
 	    cd $dir	  	    	    	
 		rm -r $files
 		echo "rm -r $files in $dir"
 	fi 			
