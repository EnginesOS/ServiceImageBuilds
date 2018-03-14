#!/bin/sh
wlans=`mktemp`

echo '{"wireless networks":['

#FIX ME only supports single wireless interface

wlan_int=` find  /sys/class/net/wlp2s0/ -name wireless |cut -f5 -d/ | head -1`

iw dev $wlan_int scan | grep SSID | cut -f2 -d: > /tmp/$wlans
n=0

cat /tmp/$wlans | while read LINE
do
 if test $n -ne 0
  then 
   echo -n ,
 else  
   n=1
 fi  
  echo '"'$LINE'"' 
done

echo ']}'