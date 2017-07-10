#!/bin/bash
if test "$1" = service
 then
  if test $# -eq 3
   then
     rm "/home/certs/store/${1}s/$2"
   fi
else
   rm "/home/certs/store/public/$1"
fi