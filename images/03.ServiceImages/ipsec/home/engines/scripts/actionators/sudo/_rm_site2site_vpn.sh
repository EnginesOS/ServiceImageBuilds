#!/bin/bash

cat /home/ivpn/entries/sites/$1/nat | while read LINE 
do
 echo $LINE |grep -v \# >/dev/null
 if test $? -eq 0
  then
    LINE=`echo $LINE | sed "s/-I/-D/"`
    iptables $LINE
  fi  
done

rm -r /home/ivpn/entries/sites/${vpn_name}

/home/engine/scripts/engine/build_configs.sh
ipsec update
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 1
fi
	
