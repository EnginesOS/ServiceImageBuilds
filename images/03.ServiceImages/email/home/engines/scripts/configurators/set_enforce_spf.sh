#!/bin/sh

if test $enforce_spf = true
 then
  touch /home/engines/scripts/configurators/saved/enforce_spf
  #sudo do shit
elif test -f /home/engines/scripts/configurators/saved/enforce_spf
  then
   #sudo undo shit
   rm /home/engines/scripts/configurators/saved/enforce_spf
fi

  
exit 0
