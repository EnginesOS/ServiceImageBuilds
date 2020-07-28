#!/bin/sh

if ! test -d /home/app/cert
 then
  mkdir /home/app/cert
  cat /home/engines/etc/ssl/certs/system.crt /home/engines/etc/ssl/keys/system.key > /home/app/cert/system_key.crt
  chmod og-rwx -R /home/app/cert
fi
