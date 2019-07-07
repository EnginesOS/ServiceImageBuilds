#!/bin/sh -x

echo "Remove $* ">> /client/log/fs_setup.log

for cmd in $*
 do
  case $cmd in
 	state)
 	     dir="/client/state/"
 		/home/remove_dir_contents.sh $dir
 		chown 21000.22020 -R $dir
 		chmod g+rwx R $dir
 		;;
 	logs)
 		dir="/client/log/"
 		/home/remove_dir_contents.sh $dir
 		chown 21000.22020 -R $dir
 		chmod g+rwx R $dir
 		;;
 	fs)	
 		dir="/dest/fs/"
 		/home/remove_dir_contents.sh $dir
 		chown 21000.22020 -R $dir	  
 		chmod g+rwx R $dir  
 		;;
 	all)
 		dir="/client/log/"
 		/home/remove_dir_contents.sh $dir
 		chown 21000.22020 -R $dir	  
 		chmod g+rwx R $dir  
 		dir="/client/state/"
 		/home/remove_dir_contents.sh $dir
 		chown 21000.22020 -R $dir	  
 		chmod g+rwx R $dir  		
 		dir="/client/fs/"
 		/home/remove_dir_contents.sh $dir
 		chown 21000.22020 -R $dir	  
 		chmod g+rwx R $dir  		
 		;;
  esac
 done

