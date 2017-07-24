#!/bin/bash




if test -d /big_tmp
 then
 TMP=/big_tmp/backup
else
 TMP=/tmp/backup
fi

mkdir $TMP
cd $TMP

tar -xpf - .

cd /home/services

scripts=`find . -name restore.sh`

for restore_script in $scripts
 do
  file_name=`echo $restore_script |  sed "/^.\//s///" | sed "/\/restore.sh/s///"`
 
  $restore_script < $TMP/$file_name
  rm -r $TMP/$file_name
done


rm -r $TMP

