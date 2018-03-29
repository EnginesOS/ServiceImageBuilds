#!/bin/sh
/home/engine/scripts/engine/build_configs.sh
ipsec update

cat /home/ivpn/entries/site/$1/nat | while read LINE 
do
 echo $LINE |grep -v \# >/dev/null
 if test $? -eq 0
  then
    iptables $LINE
  fi  
done


 
 