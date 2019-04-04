#!/bin/sh

chown -R 22010 /var/log/
chgrp containers -R /var/log/
if ! test -f /etc/ssh_host_rsa_key
 then
    dpkg-reconfigure openssh-server
 fi