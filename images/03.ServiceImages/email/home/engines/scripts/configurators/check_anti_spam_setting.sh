#!/bin/sh

if test $# -eq 2
 then 
  if test $2 = true
   then 
    touch /home/engines/scripts/configurators/saved/antispam/$1
   elif test -f /home/engines/scripts/configurators/saved/antispam/$1
   	  then 
   	    rm /home/engines/scripts/configurators/saved/antispam/$1
  fi
fi
