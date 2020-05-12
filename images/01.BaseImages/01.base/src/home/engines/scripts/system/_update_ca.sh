#!/bin/sh

if test -f /home/engines/etc/ssl/CA/engines_internal_ca.crt
 then
   update-ca-certificates
   touch /home/engines/run/flags/ca-update
fi