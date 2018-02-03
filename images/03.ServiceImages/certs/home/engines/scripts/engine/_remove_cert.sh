#!/bin/sh
if test "$1" = live/service
 then
  if test $# -eq 2
   then
     rm "/home/certs/store/${1}s/$2"
   fi
else
   rm "/home/certs/store/generated/$1"
fi