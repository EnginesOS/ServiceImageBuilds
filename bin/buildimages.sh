#/bin/bash

. bin/build_functions.sh
clear_old 
ARGS=$*
process_args	

get_release
 	

cd images
MasterImagesDir=`pwd`

if  test -z $builddir
 then
  class_list=`ls $MasterImagesDir`
else
  echo BUILD DIR  $builddir
  class_list=$builddir 
fi

build_rest=0

for class in $class_list
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




