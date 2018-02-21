#!/bin/sh -x

echo "Remove $* ">> /client/log/fs_setup.log

for cmd in $*
 do
  case $cmd in
 	state)
 	     dir="/client/state/"
 		/home/remove_dir_contents.sh $dir
 		chown 21000.22020 /client/state/
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
 		chown 21000.22020 /client/state/ 		
 		dir="//client/state/"
 		/home/remove_dir_contents.sh $dir
 		;;
  esac
 done

