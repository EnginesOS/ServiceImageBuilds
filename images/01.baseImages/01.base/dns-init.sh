#!/bin/bash

cd /home/


hostname=`hostname`
ip=`grep $hostname /etc/hosts |cut -f1`
echo server  172.17.42.1 >/tmp/ddnscmds
echo update delete ${hostname}.engines.internal >> /tmp/ddnscmds
echo "send"  >> /tmp/ddnscmds
echo " update add ${hostname}.engines.internal 30 A $ip" >> /tmp/ddnscmds
echo "send"  >> /tmp/ddnscmds

nsupdate -k /etc/ddns.key /tmp/ddnscmds

