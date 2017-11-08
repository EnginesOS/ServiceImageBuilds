#!/bin/sh
if test -f /var/run/rsyslogd.pid 
 then
   rm /var/run/rsyslogd.pid
fi 
rsyslogd  -i /var/run/rsyslogd.pid 
echo $!> /var/run/rsyslogd.pid 
