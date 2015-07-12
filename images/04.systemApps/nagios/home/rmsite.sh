#!/bin/bash
fqdn=`echo $1 |cut -f2 -d: `
host=`echo $fqdn |cut -f1 -d.`

rm /etc/nagios3/conf.d/$host.cfg
kill -HUP `ps -ax |grep nagios |grep -v grep | awk '{print $1 }'`


