#!/bin/sh
  if test $# -eq 2
  then
   entered_path=$2
   recursive=-R
 else
	entered_path=$1
	recursive=""
fi

path=`echo $entered_path |sed '/[ ;\\\"\`]/s///g ' | sed '/\.\./s///g'`
sudo -n -u data-user /home/engines/scripts/_grant_ugo_rw_access.sh $recursive $path
