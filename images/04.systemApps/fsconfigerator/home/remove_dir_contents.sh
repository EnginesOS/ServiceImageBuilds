#!/bin/sh

#function remove_dir_contents {
	#pd=`pwd
dir=$1
 	    files=`ls -a $dir | sed "/^.$/s///" | sed "/^..$/s///"`
 	    if test -n $files
 	    	then
 	    	    cd   $dir	  
 	    	    	if  test -n $files
 	    	    	 then   
 						rm -r $files
 					fi
 			fi
 			
 	#cd $pd
#}