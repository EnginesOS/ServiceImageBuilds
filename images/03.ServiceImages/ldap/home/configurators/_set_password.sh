#!/bin/sh
sudo htpasswd -c /etc/apache2/htpasswd ldap $1
