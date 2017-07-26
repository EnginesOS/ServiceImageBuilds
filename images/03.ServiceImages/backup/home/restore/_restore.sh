#!/bin/bash

restore_name=`echo $2 |sed "/[ ;\\\'\"]/s///g"`


if test -z $section
 then
 	dest=/backup_src/
 	src=/tmp/$restore_name
 else
 	dest=/backup_src/$restore_name/`dirname $section`
 	src=/tmp/$restore_name/$section
 fi

case $1 in
 replace)
 echo "replace $src $dest"
	cp -rp $src $dest
 ;;
 rename)
 	echo "rename $src $dest_restored"
	cp -rp $src $dest_restored
 ;;
 missing)
 	echo "missing $src $dest"
	cp -rnp $src $dest
 ;;
esac

echo "Restored $restore_name $replace $source $section"

exit 0
