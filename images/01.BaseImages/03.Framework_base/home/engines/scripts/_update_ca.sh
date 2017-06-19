#!/bin/sh

if test -f /usr/local/share/ca-certificates/engines_internal_ca.crt
 then
   sudo -n update-ca-certificates
   touch /engines/var/run/flags/ca-update
fi