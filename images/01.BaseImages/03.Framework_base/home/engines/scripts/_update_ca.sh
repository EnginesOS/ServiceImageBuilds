#!/bin/sh

if test -f /usr/local/share/ca-certificates/engines_internal_ca.crt
 then
   sudo -n update-ca-certificates
   touch /home/engines/run/flags/ca-update
fi