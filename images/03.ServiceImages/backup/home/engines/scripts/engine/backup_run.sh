#!/bin/sh
. /home/engines/scripts/engine/backup_dirs.sh

echo backup_run > /home/engines/run/flags/backup_run

. /home/engines/scripts/configurators/saved/backup_email

for backup in `ls $Backup_ConfigDir |grep -v duply_conf`
 do         
 echo "Running Backup $backup"              
 
	ts=`date +%d_%m_%y`
	bfn=${backup}_${ts}.log        	
        		
	if test -f $Backup_ConfigDir/$backup/email
	 then 
	  email=`cat $Backup_ConfigDir/$backup/email`
	else
	  email=$backup_email
	fi
     
	if test -f $Backup_ConfigDir/$backup/backup_type
	  then
	    backup_type=`cat $Backup_ConfigDir/$backup/backup_type`
	else
	   backup_type=full
	fi

	/home/engines/scripts/engine/run_duply.sh $backup backup   $backup_type --s3-use-new-style > $Backup_LogDir/$bfn           
	result=`grep "Finished state FAILED"  $Backup_LogDir/$bfn`
	if test $? -ne 0
	 then
	  subject="Sucessfully backed up $backup" 
	else
 	 subject="$backup: $result " 
	fi     
         	
	echo $email >> $Backup_LogDir/$bfn
	echo "Subject:$subject" > /tmp/email                 
	cat /tmp/email $Backup_LogDir/$bfn | sendmail -t $email -f $email
done 

rm /home/engines/run/flags/backup_run