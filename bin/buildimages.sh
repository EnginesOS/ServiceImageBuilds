#/bin/bash

. bin/build_functions.sh
clear_old 
ARGS=$*
process_args	

get_edition_and_release

clear_old

cd images
MasterImagesDir=`pwd`
echo build $container
if test -z $container
 then
   if  test -z $builddir
     then
       class_list=`ls $MasterImagesDir`
   else
      class_list=$builddir 
  fi
else
 dir=`find . -type d  -name $container`
  if test -z "$dir"
   then 
    echo Failed to find $container
   else
    process_build_dir
  fi
 exit 
fi

for class in $class_list
 do 
   cd $class	 
	for dir in `find  -maxdepth 1 -type d  |grep / |sort`
	  do
	    process_build_dir
       done
    cd ..     
done

echo Clearing unlinked images
docker rmi $( docker images -f "dangling=true" -q) &>/dev/null




