#!/bin/sh
secret=SECRET

cat /home/engines/templates/clients.conf | sed "/SECRET/s//$secret/" \
  > /etc//etc/radius/clients.conf