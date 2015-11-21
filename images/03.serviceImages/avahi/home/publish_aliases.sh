#!/bin/bash
while test 1 -ne 0
do
python /home/avahi-alias.py 
echo $! > /tmp/avahi-publisher.pid
done