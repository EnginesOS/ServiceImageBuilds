#!/bin/bash

cat /home/ivpn/entries/site/$1/nat | while read LINE 
do
 echo $LINE |grep -v \# >/dev/null
 if test $? -eq 0
  then
    LINE=`echo $LINE | sed "s/-I/-D/"`
    iptables $LINE
  fi  
done

rm -r /home/ivpn/entries/site/${vpn_name}
/home/engine/scripts/engine/build_configs.sh
ipsec update

	
echo "Success"
exit 0
