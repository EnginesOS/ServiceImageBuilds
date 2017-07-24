#!/bin/bash

restore_name=`echo $2` |sed "/[ ;\\\'\"]/s///g"`
if ! test -z $section
 then
   restore_name=restore_name/$section
fi

case $1 in
 replace)
	cp -rp /tmp/$restore_name /backup_src/$restore_name
 ;;
 rename)
	cp -rp /tmp/$restore_name /backup_src/$restore_name/restored
 ;;
 missing)
	cp -rnp /tmp/$restore_name /backup_src/$restore_name
 ;;
esac

exit 0
