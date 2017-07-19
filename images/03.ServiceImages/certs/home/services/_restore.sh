#!/bin/bash
cd /
tar -xpf - 2> /tmp/tar.errs
if test $? -ne 0
 then 
   cat  /tmp/tar.errs  >&2
   exit -1
fi

tar -xpf /tmp/cert_auth/backup.*
 
r=$?

rm -r /tmp/cert_auth/backup.*

exit $r