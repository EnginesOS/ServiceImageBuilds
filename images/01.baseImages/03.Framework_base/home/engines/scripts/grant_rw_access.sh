#!/bin/sh
path=`echo $1 |sed '/[ ;\\\"\`]/s///g ' | sed '/\.\./s///g'`
sudo -u data-user /home/engines/scripts/_grant_rw_access.sh $path