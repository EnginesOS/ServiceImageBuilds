#!/bin/sh
htpasswd -b -c /etc/apache2/htpasswd ldap "$1"
