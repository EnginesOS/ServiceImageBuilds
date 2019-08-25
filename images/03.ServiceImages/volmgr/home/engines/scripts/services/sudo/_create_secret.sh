#!/bin/sh


if ! test -d  /var/secrets/${container_type}s/${parent_engine}/
 then
   mkdir -p /var/secrets/${container_type}s/${parent_engine}/
fi   

dd if=/dev/urandom count=$1 bs=1  | od -h | awk '{ print $2$3$4$6$6$7$8$9}'\
	| head -1 >/var/secrets/${container_type}s/${parent_engine}/${service_handle} 

chown -R ${ContUser}.containers /var/secrets/${container_type}s/${parent_engine}/${service_handle}
chmod 440 /var/secrets/${container_type}s/${parent_engine}/${service_handle}