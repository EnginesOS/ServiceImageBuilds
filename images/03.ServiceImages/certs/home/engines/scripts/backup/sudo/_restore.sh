#!/bin/sh
cd /
tar -xpf - 2> /tmp/tar.errs
r=$?
if test $r -ne 0
 then
   cat  /tmp/tar.errs  >&2
   exit $r
fi

exit $r
