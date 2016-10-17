#!/bin/bash


 if ! test -f /var/run/engines/grey.pid
  then
    kill -TERM `cat /var/run/engines/grey.pid`
 fi
 
