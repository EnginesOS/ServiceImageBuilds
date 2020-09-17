#!/bin/sh

kinit -kt /etc/krb5kdc/keys/ftp.keytab
cat /home/engines/templates/ldap/first_run/ftp_users.ldif | ldapadd -H ldap://ldap.engines.internal/
cat /home/engines/templates/ldap/first_run/next_id.ldif | ldapadd -H ldap://ldap.engines.internal/
ssh-keygen -e -m PEM -f /etc/ssh/ssh_host_rsa_key

kdestroy