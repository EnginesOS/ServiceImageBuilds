#!/bin/sh
cron_list_file=`mktemp`
 /home/cron/bin/fcrontab -l | sed "/*/s//STAR/g"  > $cron_list_file
first=1
echo '{"cron_jobs":['
cat $cron_list_file | while read LINE
do
if test $first -eq 1
 then
  first=0
else
 echo -n ","
fi
cront=`echo "$LINE" | cut -f1-5 -d" "`
cronl=`echo "$LINE" | cut -f6- -d" "`
tim=`echo $cront | sed "/STAR/s//*/g"`
echo '{"'$cronl'":"'"$tim"'"}'

done
echo ']}'


rm $cron_list_file