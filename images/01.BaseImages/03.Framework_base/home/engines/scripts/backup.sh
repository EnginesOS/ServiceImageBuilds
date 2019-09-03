#!/bin/sh

cd /home/services

scripts=`find . -name backup.sh`

if test -d /big_tmp
 then
 TMP=/big_tmp/backup
else
 TMP=/tmp/backup
fi

mkdir $TMP

for backup_script in $scripts
 do
  file_name=`echo $backup_script |  sed "/^.\//s///" | sed "/\/backup.sh/s///"`
  mkdir -p  $TMP/`dirname $filename`
  $backup_script > $TMP/$file_name
done

cd $TMP

tar -cpf - .
rm -r $TMP

