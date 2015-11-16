#!/bin/bash

cd /home/avahi/hosts
domains=""
for host in `ls ` 
 do 
 	domains="$domains $host.engines.local "
done

/home/avahi-alias.py $domains &
PUBLISHER_PID=$!
echo $PUBLISHER_PID >/tmp/publish.pid
