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
#FIXME needs to handle target of symbolic link
echo chmod go-wr $recursive /home/$path
chmod go-rw $recursive /home/$path
 