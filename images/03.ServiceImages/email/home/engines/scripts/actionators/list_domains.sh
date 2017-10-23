#!/bin/bash

domains=`ldapsearch -x -b "ou=domains,ou=email,ou=Services,dc=engines,dc=internal" -H ldap://ldap// -LLL "(ObjectClass=dNSDomain)" dc |grep ^dc:|cut -f2 -d" "`
echo -n '{"domains":['
n=0

for domain in $domains
do
 if test $n == 0
  then 
   n=2
 else
   echo -n ','
 fi
 echo -n '"'$domain'"'
done

echo ']}'