#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
if test "$1" = live/service
 then
  if test $# -eq 2
   then
     rm "$StoreRoot/${1}s/$2"
   fi
else
   rm "$StoreRoot/store/$1"
fi