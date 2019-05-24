#!/bin/sh
vpn_name=$1
/home/engines/scripts/engine/build_configs.sh
/home/engines/scripts/engine/build_secrets.sh
ipsec update

cat /home/ivpn/entries/sites/$1/nat | while read LINE 
do
 echo "$LINE" |grep -v \# >/dev/null
 if test $? -eq 0
  then
    iptables $LINE
  fi  
done


 
 