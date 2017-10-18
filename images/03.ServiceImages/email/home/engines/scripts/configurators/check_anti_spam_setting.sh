#!/bin/bash

if test $# -eq 2
 then 
  if test $2 -eq 1
   then 
    touch /home/engines/scripts/configurators/saved/antispam/$1
   elif test -f /home/engines/scripts/configurators/saved/antispam/$1
   	  then 
   	    rm /home/engines/scripts/configurators/saved/antispam/$1
  fi
fi


#if test $# -eq 2
#   	 then 
#   	if test $2 -eq 1
#   	 then 
#   	 touch /home/engines/scripts/configurators/saved/antispam/$1
#   	 else
#   	  if test -f /home/engines/scripts/configurators/saved/antispam/$1
#   	   then 
#   	    rm   /home/engines/scripts/configurators/saved/antispam/$1
#   	  fi
#   	fi
# fi


