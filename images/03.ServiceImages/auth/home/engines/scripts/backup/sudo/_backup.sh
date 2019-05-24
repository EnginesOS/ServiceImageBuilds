#!/bin/bash

kdb5_util dump - 2>/tmp/backup.errs
r=$?
if test $r -ne 0
 then
  cat /tmp/backup.errs 
fi  
exit $r