#!/bin/sh

sudo -n /home/engines/scripts/first_run/_first_run.sh
#kinit -kt /etc/krb5kdc/keys/ftp.keytab
#cat /home/engines/templates/ftp/init.tmpl | ldapadd -H ldap://ldap/