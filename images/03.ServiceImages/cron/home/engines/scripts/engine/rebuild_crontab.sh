#!/bin/sh
rm /home/cron/spool/cron.orig

 for job in /home/cron/entries/*/*
  do
   note=`cat $job/notification_address`
    if test $note = default
     then
       note_address=`cat /home/engines/scripts/configurators/saved/default_notifcation_address`
    else
      note_address=$note
    fi
if ! test -z $note_address
 then
   title=`cat $job/title`   
   note_details='|sendmail -f cron@'$defaultdomain' -s "Cron '$title'" '$note_address
else
  note_details='| /dev/null'
fi
when=`cat $job/when`
cmd=`cat $job/cmd`

   echo "$when"  $cmd $note_details >> /home/cron/spool/cron.orig
  done

/home/cron/bin/fcrontab -z
