#!/bin/sh
o=`mktemp`
if test $1 = true
 then
  type=''
 else
  type=-update
fi 
cat - > $o
 kdb5_util load $type $o 2>/tmp/tar.errs
r=$?
rm $o
if test $r -ne 0
 then
  echo /tmp/tar.errs 
  exit $r
fi  

