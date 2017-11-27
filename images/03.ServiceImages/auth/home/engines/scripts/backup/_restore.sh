#!/bin/sh

cat - | kdb5_util load -update - 2>/tmp/tar.errs
r=$?
if test $r -ne 0
 then
  echo /tmp/tar.errs 
  exit $r
fi  

