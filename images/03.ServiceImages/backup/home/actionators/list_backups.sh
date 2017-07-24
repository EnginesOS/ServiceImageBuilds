#!/bin/bash
cd  /home/backup/.duply/
backups=`find . -type d |grep / |sed "/\.\//s///"`

echo -n '{"backups":['

for backup in $backups
do
 echo -n '"'$backup'",'
done

echo ']}'