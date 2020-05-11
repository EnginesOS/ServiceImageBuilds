#!/bin/sh

/home/engines/scripts/ldap/ldapsearch.sh $1 $2 dn | grep dn: | cut -f2- -d: