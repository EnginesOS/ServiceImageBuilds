#!/bin/bash

/home/engines/scripts/signal/_kill_postfix.sh $1

if ! test HUP = $1
 then
  kill -$1 `cat /tmp/sleep.pid`
  rm /tmp/sleep.pid
fi