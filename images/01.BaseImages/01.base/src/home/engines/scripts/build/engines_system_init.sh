#!/bin/sh

groupadd -g 22020 containers 

mkdir /var/run/engines 
chgrp containers /var/run/engines && chmod g+w /var/run/engines  
mkdir -p  /home/engines/etc/ssl/CA 
ln -s /home/engines/etc/ssl/CA /usr/share/ca-certificates/engines 
echo engines/engines_internal_ca.crt >> /etc/ca-certificates.conf

/home/engines/scripts/build/install_utf8_langauges.sh 
rm -r /tmp/* /home/engines/scripts/build/install_utf8_langauges.sh 
rm /etc/rsyslog.d/50-default.conf 

chmod -R go-w /etc/mail/ 
echo y y |sendmailconfig --no-reload 
chmod g+w /var/spool/mqueue 
chmod -R go-rw /etc/sudoers 