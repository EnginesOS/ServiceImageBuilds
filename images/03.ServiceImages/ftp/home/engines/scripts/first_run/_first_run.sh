#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ftp.keytab
cat /home/engines/templates/ldap/init.tmpl | ldapadd -H ldap://ldap/