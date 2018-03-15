#!/bin/sh


if ! test -d  /var/secrets/${container_type/}${parent_engine}/
 then
   mkdir -p /var/secrets/${container_type/}${parent_engine}/
fi   

dd if=/dev/urandom count=16 bs=1  | od -h | awk '{ print $2$3$4$6$6$7$8$9}' >/var/secrets/${container_type}/${parent_engine}/${service_handle}

chown -R ${user}.${group} /var/secrets/${container_type}/${parent_engine}/${service_handle}
chmod o-rxw /var/secrets/${container_type}/${parent_engine}/${service_handle}