#!/bin/sh


/usr/sbin/kadmind -P /var/run/krb5admin.pid 
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n 
