#!/bin/bash
if test -z $1
 then
    kill -TERM ` cat /var/run/slapd.pid /var/run/saslauthd.pid`
   else
     slapcat_args="-b $*" 
  fi 
slapcat $slapcat_args

