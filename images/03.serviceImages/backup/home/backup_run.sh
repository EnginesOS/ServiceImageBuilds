#!/bin/sh
Backup_ConfigDir=/home/backup/.duply/
for backup in `ls $Backup_ConfigDir`
        do
        		ts=`date +%d_%m_%y`
        		bfn=${backup}_${ts}.log        		
                duply $backup backup > /var/log/backup/$bfn
        done
