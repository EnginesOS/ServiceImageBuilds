#!/bin/bash


 /home/engines/scripts/signal/_kill_postfix.sh $1
echo  /tmp/sleep.pid kill -$1 `cat /tmp/sleep.pid`
if ! test HUP = $1
 then
  kill -$1 `cat /tmp/sleep.pid`
fi