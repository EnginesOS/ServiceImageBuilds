#!/bin/bash

while test 1 -ne 0
 do
   /home/engines/scripts/engine/avahi-alias.py > /var/log/publish.out 2>/dev/null
done