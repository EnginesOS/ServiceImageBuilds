#!/bin/sh
 
rm /home/cron/spool/cron.orig

 for job in /home/cron/entries/*/*
  do
   cat $job/cmd  $job/when >> /home/cron/spool/cron.orig
   note=`cat $job/notification`
    if test -z $note
		next
    elif test $note = default
     then
       note_address=`cat /home/engines/scripts/configurators/saved/default_notifcation_address`
    else
      note_address=$note
    fi
   echo '|sendmail -f cron@'$default domain' -s "Cron '`basename $job`'"' > /home/cron/spool/cron.orig
  done
   
/home/cron/bin/fcrontab -z