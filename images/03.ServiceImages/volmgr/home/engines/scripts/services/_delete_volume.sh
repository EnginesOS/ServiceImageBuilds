#!/bin/bash

if test -d /var/fs/local/${parent_engine}/${service_name} 
 then
	rm -r  /var/fs/local/${parent_engine}/${service_name}
  else
  	echo "No such dir /var/fs/local/${parent_engine}/${service_name}"
  fi
exit 0	

