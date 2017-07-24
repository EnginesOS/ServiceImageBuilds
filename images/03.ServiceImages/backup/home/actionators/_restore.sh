#!/bin/bash


restore_name=`echo $2` |sed "/[ ;\\\'\"]/s///g"`

case $1 in
replace)
 cp -rp /tmp/$restore_name /backup_src/
 ;;
rename)
  cp -rp /tmp/$restore_name /backup_src/$restore_name/restored
;;
missing)
 cp -rnp /tmp/$restore_name /backup_src/
;;
esac



