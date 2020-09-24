#!/bin/sh

chown -R 22010 /var/log/
chgrp containers -R /var/log/

if ! test -f /etc/ssh_host_rsa_key
 then
    dpkg-reconfigure openssh-server
 fi
 
if ! test -f /etc/ssh_host_pem_key
 then
 ssh-keygen -e -m PEM -f /etc/ssh/ssh_host_rsa_key > /etc/ssh/ssh_host_pem_key
fi 

 if ! test -d /etc/sftp/authorized_keys/
  then
   mkdir -p /etc/sftp/authorized_keys/
 fi