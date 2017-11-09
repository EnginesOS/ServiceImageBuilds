#!/bin/sh

echo delprinc  host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local 
r=$?

if test $r -eq 0 
 then
  echo "Success"
  rm -r /etc/krb5kdc/services/$parent_engine 
fi

exit $r

