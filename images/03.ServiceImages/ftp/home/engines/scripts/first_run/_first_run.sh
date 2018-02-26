#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ftp.keytab
cat /home/engines/templates/ldap/init.ldif | ldapadd -H ldap://ldap/