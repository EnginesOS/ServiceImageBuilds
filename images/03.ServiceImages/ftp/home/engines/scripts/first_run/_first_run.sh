#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ftp.keytab
cat /home/engines/templates/ldap/first_run/ftp_users.ldif | ldapadd -H ldap://ldap/
cat /home/engines/templates/ldap/first_run/next_id.ldif | ldapadd -H ldap://ldap/
kdestroy