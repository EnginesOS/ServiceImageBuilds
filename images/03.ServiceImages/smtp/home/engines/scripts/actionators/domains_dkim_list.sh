#!/bin/sh



echo -n '{"dkim_domains":['

if test -d /etc/opendkim/keys/
 then
  cd /etc/opendkim/keys/
  n=0
  for domain in `ls`
   do
    if test $n -ne 0
     then
      echo -n ","
      n=1
    fi  
    echo -n '"'$domain'"'
done
fi

echo ']}'

