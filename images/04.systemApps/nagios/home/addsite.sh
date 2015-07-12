#!/bin/bash
fqdn=`echo $1 |cut -f2 -d: `
host=`echo $fqdn |cut -f1 -d.`
port=`echo $1  |cut -f3 -d:`
cat /home/nagios.host.tmpl | sed "/HNAME/s//$host/" | sed "/DOMAIN/s//$fqdn/" | sed "/PORT/s//$port/"> /etc/nagios3/conf.d/$host.cfg
kill -HUP `ps ax |grep nagios |grep -v grep | awk '{print $1 }'`

