#!/bin/sh

 if ! test -d /var/log/apache2/
 then
  mkdir -p /var/log/apache2/
 fi  

/usr/sbin/apache2ctl -DFOREGROUND &       
echo -n " $!" >  $PID_FILE
echo started

