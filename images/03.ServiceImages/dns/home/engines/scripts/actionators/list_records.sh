#!/bin/sh
cat /home/bind/engines/zones/named.conf.$domain_name |egrep "CNAME|TXT|A|IN|NS|MX" 