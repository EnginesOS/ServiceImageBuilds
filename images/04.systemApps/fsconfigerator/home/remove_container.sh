#!/bin/sh -x

function remove_dir_contents {
	pd=`pwd`
 	    files=`ls -a $dir | sed "/^.$/s///" | sed "/^..$/s///"`
 	    if test -n $files
 	    	then
 	    	    cd   $dir	    
 				rm -r $files
 			fi
 			
 	cd $pd
}

for cmd in $*
 do
  case $cmd in
 	state)
 	     dir="/client/state/"
 		remove_dir_contents
 		;;
 	logs)
 		dir="/client/log/"
 		remove_dir_contents
 		;;
 	fs)	
 		dir="/dest/fs/"
 		remove_dir_contents
 	    
 		;;
 	all)
 		dir="/client/log/"
 		remove_dir_contents
 		
 		dir="//client/state/"
 		remove_dir_contents
 		
 		dir="/dest/fs/"
 		remove_dir_contents
 		
 		;;
  esac
 done



