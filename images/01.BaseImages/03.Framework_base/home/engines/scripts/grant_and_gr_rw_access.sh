#!/bin/sh

if test $# -eq 2
 then
   entered_path=$2
   recursive=-R
else
	entered_path=$1
	recursive=""
fi

sudo -n /home/engines/scripts/_grant_and_gr_rw_access.sh $recursive $path

