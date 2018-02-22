#!/bin/bash
if test -z $1
 then
    kill -TERM ` cat /home/engines/run/slapd.pid /home/engines/run/saslauthd.pid`
   else
     slapcat_args="-b $*" 
  fi 
slapcat $slapcat_args

