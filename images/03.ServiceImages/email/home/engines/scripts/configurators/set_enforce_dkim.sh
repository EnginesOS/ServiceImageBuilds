#!/bin/sh

if test $enforce_dkim = true
 then
  touch /home/engines/scripts/configurators/saved/enforce_dkim
  #sudo do shit
elif test -f /home/engines/scripts/configurators/saved/enforce_dkim
  then
   #sudo undo shit
   rm /home/engines/scripts/configurators/saved/enforce_dkim
fi

exit 0
