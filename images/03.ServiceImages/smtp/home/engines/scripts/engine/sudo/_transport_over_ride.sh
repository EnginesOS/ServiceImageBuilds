#!/bin/sh

if test -f /home/engines/run/
 then
  cp /home/engines/run/transport.over_ride /etc/postfix/maps/transport.over_ride
  cat /etc/postfix/maps/transport.over_ride >> /etc/postfix/maps/transport
fi
