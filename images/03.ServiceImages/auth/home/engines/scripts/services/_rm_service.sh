#!/bin/sh

echo delprinc  host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local 
r=$?

if test $r -eq 0 
 then
  rm -r /etc/krb5kdc/${container_type}s/$parent_engine 
fi

exit $r

