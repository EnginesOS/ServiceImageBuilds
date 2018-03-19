#!/bin/sh
if test -f /var/secrets/${container_type}s/${parent_engine}/${service_handle}
 then
	echo "rm /var/secrets/${container_type}s/${parent_engine}/${service_handle}"
	rm -r  /var/secrets/${container_type}/${parent_engine}/${service_handle}
  else
  	echo "No such dir /var/secrets/${container_type}s/${parent_engine}/${service_handle}"
  fi
exit 0	

