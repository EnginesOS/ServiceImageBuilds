#!/bin/bash

restore_name=`echo $2 |sed "/[ ;\\\'\"]/s///g"`
if ! test -z $section
 then
   restore_name=restore_name/$section
fi

if test -z $section
 then
 	dest=/backup_src/
 	src=/tmp/$restore_name
 else
 	dest=/backup_src/$section
 	src=backup_src/`dirname $section`
 fi

case $1 in
 replace)
	cp -rp $src $dest
 ;;
 rename)
	cp -rp $src $dest_restored
 ;;
 missing)
	cp -rnp $src $dest
 ;;
esac

echo "Restored $restore_name $replace $source $section"

exit 0
