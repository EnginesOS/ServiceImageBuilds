#/bin/bash

. bin/build_functions.sh
clear_old 

process_args	

get_release
 	

cd images

if ! test -z $builddir
 then
 echo BUILD DIR  $builddir
   
fi

MasterImagesDir=`pwd`
build_rest=0

for class in `ls $MasterImagesDir`
 do 
	cd $class
	 if test $build_rest -ne 0
	  then
		rm `find . -name last_built`
	 fi 
	for dir in `find  -maxdepth 1 -type d  |grep /`
	  do
	    process_build_dir
       done
  cd $MasterImagesDir	
done

echo Clearing unlinked images
docker rmi $( docker images -f "dangling=true" -q) &>/dev/null




