#!/bin/bash
sudo -n /home/engines/scripts/backup/_restore.sh >& /tmp/restore.errs
if test $? -ne 0
 then 
   cat  /tmp/restore.errs  >&2
   exit -1
fi
 
 exit 0
