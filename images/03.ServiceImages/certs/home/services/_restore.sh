#!/bin/bash
cd /
tar -xzpf -  2>/tmp/tar.errs
if test $? -ne 0
 then 
   cat  /tmp/tar.errs  >&2
   exit -1
fi

tar -xzpf /tmp/cert_auth/backup.*
 
r=$?

rm -r /tmp/cert_auth/backup.*

exit $r