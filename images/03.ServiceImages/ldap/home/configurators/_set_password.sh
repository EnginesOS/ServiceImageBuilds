#!/bin/sh
htpasswd -c /etc/apache2/htpasswd ldap $1
