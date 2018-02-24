#!/bin/bash

if  test -f /home/engines/run/grey.pid
  then
    kill -TERM `cat /home/engines/run/grey.pid`
fi
 
