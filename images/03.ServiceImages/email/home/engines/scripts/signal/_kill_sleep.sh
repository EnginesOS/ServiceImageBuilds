#!/bin/bash


 /home/engines/scripts/signal/_kill_postfix.sh $1

if ! test '-HUP' = $1
 then
  kill `cat /tmp/sleep.pid`
fi