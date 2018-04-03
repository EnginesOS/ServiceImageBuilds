#!/bin/sh

dd if=/dev/urandom of=/etc/freeradius/certs/random count=10

secret=SECRET

cat /home/engines/templates/clients.conf | sed "/SECRET/s//$secret/" \
  > /etc/radius/clients.conf