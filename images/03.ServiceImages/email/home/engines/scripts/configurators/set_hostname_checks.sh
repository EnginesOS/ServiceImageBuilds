#!/bin/sh

if test $hostname_checks = true
 then
  touch /home/engines/scripts/configurators/saved/hostname_checks
  #sudo do shit
elif test -f /home/engines/scripts/configurators/saved/hostname_checks
  then
   #sudo undo shit
   rm /home/engines/scripts/configurators/saved/hostname_checks
fi

exit 0
