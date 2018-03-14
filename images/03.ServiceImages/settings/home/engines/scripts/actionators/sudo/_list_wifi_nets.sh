#!/bin/sh
wlans=`mktemp`

echo '{"wireless networks":['

#FIX ME only supports single wireless interface

for dir in `find /sys/class/net/`
 do 
   if test -d $dir/wireless
    then
      wlan_int=`echo $dir |cut -f5 -d/`
      break
    fi  
 done 

#wlan_int=` find  /sys/class/net/ -name wireless |cut -f5 -d/ | head -1`

iw dev $wlan_int scan | grep SSID | cut -f2 -d: > $wlans
n=0

cat $wlans | while read LINE
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