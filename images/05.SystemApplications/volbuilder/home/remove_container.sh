#!/bin/sh -x



for cmd in $*
 do
  case $cmd in
 	state)
 	     dir="/client/state/"
 		/home/remove_dir_contents.sh $dir
 		;;
 	logs)
 		dir="/client/log/"
 		/home/remove_dir_contents.sh $dir
 		;;
 	fs)	
 		dir="/dest/fs/"
 		/home/remove_dir_contents.sh $dir
 	    
 		;;
 	all)
 		dir="/client/log/"
 		/home/remove_dir_contents.sh $dir
 		
 		dir="//client/state/"
 		/home/remove_dir_contents.sh $dir
 		
 		dir="/dest/fs/"
 		/home/remove_dir_contents.sh $dir
 		
 		;;
  esac
 done



