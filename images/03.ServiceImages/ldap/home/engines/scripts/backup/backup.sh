#!/bin/bash
sudo -n /home/engines/scripts/backup/_backup.sh >& /tmp/backup.errs
if test $? -ne 0
 then 
   cat  /tmp/backup.errs  >&2
   exit -1
fi
 
 exit 0