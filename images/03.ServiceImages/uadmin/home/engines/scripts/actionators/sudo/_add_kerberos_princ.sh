#!/bin/bash

cat - | grep -v admin | kadmin -p uadmin/admin@ENGINES.INTERNAL -kt /etc/krb5kdc/keys/uadmin_kadmin.keytab

 
 
 