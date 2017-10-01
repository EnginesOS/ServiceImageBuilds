#!/bin/sh

postfix set-permissions
chown postfix /etc/postfix/smarthost_passwd* /home/configurators/saved/ /etc/postfix/mailname /etc/postfix/transport.db /etc/postfix/transport /etc/postfix/mysql 