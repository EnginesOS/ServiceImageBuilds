#!/bin/sh
o=`mktemp`
if test -z $1
 then
  type=''
elif test $1 = true
 then
  type=''
 else
  type=-update
fi 
cat - > $o
 kdb5_util load $type $o 2>/tmp/restore.errs
r=$?
rm $o
if test $r -ne 0
 then
  cat /tmp/restore.errs 
  exit $r
fi  

