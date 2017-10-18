#!/bin/sh
cp -rp /tmp/spool_postfix/* /var/spool/postfix
rm -r /tmp/spool_postfix/
postfix set-permissions
chown postfix /etc/postfix/smarthost_passwd* /home/engines/scripts/configurators/saved/ /etc/postfix/mailname /etc/postfix/transport.db /etc/postfix/transport /etc/postfix/mysql 