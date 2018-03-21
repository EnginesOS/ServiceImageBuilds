#!/bin/sh
secret=SECRET

cat /home/engines/templates/clients.conf | sed "/SECRET/s//$secret/" \
  > /etc/radius/clients.conf