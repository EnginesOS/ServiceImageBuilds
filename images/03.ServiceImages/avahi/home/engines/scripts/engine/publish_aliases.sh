#!/bin/sh

while test 1 -ne 0
 do
   /home/engines/scripts/engine/avahi-alias.py 1>> /var/log/publish.out 2>> /var/log/publish.err
done