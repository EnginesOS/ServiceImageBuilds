#!/bin/sh
o=`mktemp`

cat - > $o
 kdb5_util load -update $o 2>/tmp/tar.errs
r=$?
rm $o
if test $r -ne 0
 then
  echo /tmp/tar.errs 
  exit $r
fi  

