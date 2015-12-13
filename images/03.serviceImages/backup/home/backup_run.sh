#!/bin/sh
email=`/home/configurators/saved/backup_email_hash`

Backup_ConfigDir=/home/backup/.duply/
for backup in `ls $Backup_ConfigDir`
        do
        		ts=`date +%d_%m_%y`
        		bfn=${backup}_${ts}.log        		
                duply $backup backup   --s3-use-new-style > /var/log/backup/$bfn
                	if test $? -eq 0
                		then
                			subject="Sucessfully backed up $backup" 
                		else
                			subject="Problem with backup $backup" 
                	fi
        done
        
        

        cat /var/log/backup/$bfn | sendmail -t $email -f $email -u "$subject" 