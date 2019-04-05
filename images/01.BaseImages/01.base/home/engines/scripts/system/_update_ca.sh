#!/bin/sh

if test -f /home/engines/etc/ssl/engines_internal_ca.crt
 then
   cp /home/engines/etc/ssl/engines_internal_ca.crt  /usr/share/ca-certificates/engines
   cp /home/engines/etc/ssl/engines_internal_ca.crt  /etc/ssl/certs/engines_internal_ca.pem
   update-ca-certificates
   touch /home/engines/run/flags/ca-update
fi