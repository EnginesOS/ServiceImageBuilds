#!/bin/bash

echo populating /etc/ldap/slapd.d
cp -r /home/slapd.d /etc/ldap/
mv /home/slapd.d /home/slapd.d.init
touch /engines/var/run/flags/first_run
