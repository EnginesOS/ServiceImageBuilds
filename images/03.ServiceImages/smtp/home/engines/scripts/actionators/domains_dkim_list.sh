#!/bin/sh
cd /etc/dkim/keys/
echo -n '{"dkim_domains":['
n=0
for domain in `ls`
 do
  if test $n -ne 0
   then
    echo =n ,
    n=1
  fi  
  echo -n '"'$domain'"'
done

echo ']}'

