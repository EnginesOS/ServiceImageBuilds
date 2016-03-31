#!/bin/bash

if test $? -eq 2
   	 then 
   	if test $2 -eq 1
   	 then 
   	 touch /home/configurators/saved/antispam/$1
   	 else
   	  if test -f /home/configurators/saved/antispam/$1
   	   then 
   	    rm   /home/configurators/saved/antispam/$1
   	  fi
   	fi
 

