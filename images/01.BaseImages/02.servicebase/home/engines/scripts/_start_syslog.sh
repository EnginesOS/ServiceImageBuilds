#!/bin/sh
if test -f /var/run/rsyslogd.pid 
 then
   rm /var/run/rsyslogd.pid
fi 
rsyslogd  -i /var/run/rsyslogd.pid 
echo started rsysog pid $!>>  /home/engines/run/flags/signals 
echo With record pid as `cat  /var/run/rsyslogd.pid`  >>  /home/engines/run/flags/signals 