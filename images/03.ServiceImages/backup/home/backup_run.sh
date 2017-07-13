#!/bin/sh

default_email=`cat /home/configurators/saved/backup_email`
Backup_ConfigDir=/home/backup/.duply/

for backup in `ls $Backup_ConfigDir |grep -v duply_conf`
 do         
 echo "Running Backup $backup"              
 
	ts=`date +%d_%m_%y`
	bfn=${backup}_${ts}.log        	
        		
	if test -f $Backup_ConfigDir/$backup/email
	 then 
	  email=`cat $Backup_ConfigDir/$backup/email`
	else
	  email=$default_email
	fi
     
	if test -f $Backup_ConfigDir/$backup/backup_type
	  then
	    backup_type=`cat $Backup_ConfigDir/$backup/backup_type`
	else
	   backup_type=full
	fi

	duply $backup backup   $backup_type --s3-use-new-style > /var/log/backup/$bfn           
	result=`grep "Finished state FAILED"  /var/log/backup/$bfn`
	if test $? -ne 0
	 then
	  subject="Sucessfully backed up $backup" 
	else
 	 subject="$backup: $result " 
	fi     
         	
	echo $email >> /var/log/backup/$bfn
	echo "Subject:$subject" > /tmp/email                 
	cat /tmp/email /var/log/backup/$bfn | sendmail -t $email -f $email
done 