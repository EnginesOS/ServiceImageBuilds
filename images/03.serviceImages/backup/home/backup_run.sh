#!/bin/sh
Backup_ConfigDir=/home/backup/.duply/
for backup in `ls $Backup_ConfigDir`
        do
        		ts=`date +%d_%m_%y`
        		bfn=${backup}_${ts}.log        		
                duply $backup backup   --s3-use-new-style > /var/log/backup/$bfn
                	if test $? -eq 0
                		then
                			echo "Sucessfully backed up $backup"
                		else
                			echo "Problem with backup $backup"
                	fi
        done
