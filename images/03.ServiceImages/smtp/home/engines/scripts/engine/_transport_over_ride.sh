#!/bin/sh

if test -f /home/engines/run/transport.over_ride
 then
  cp /home/engines/run/transport.over_ride /etc/postfix/maps/transport.over_ride
  cp /etc/postfix/maps/transport.over_ride /etc/postfix/maps/transport
fi
