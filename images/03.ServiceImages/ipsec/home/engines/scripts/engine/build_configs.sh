#!/bin/sh
rm /etc/ipsec.conf
cat /etc/ipsec.head  > /etc/ipsec.conf


 for entry in ` ls /home/ivpn/entries/sites/*/entry`
  do
  	echo " " >> /etc/ipsec.conf
  	cat /home/ivpn/entries/sites/*/entry >> /etc/ipsec.conf
 done
 
 