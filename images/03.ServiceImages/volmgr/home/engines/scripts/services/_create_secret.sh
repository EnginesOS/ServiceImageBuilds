#!/bin/sh


if ! test -d  /var/secrets/${container_type}s/${parent_engine}/
 then
   mkdir -p /var/secrets/${container_type}s/${parent_engine}/
fi   

dd if=/dev/urandom count=16 bs=1  | od -h | awk '{ print $2$3$4$6$6$7$8$9}' >/var/secrets/${container_type}s/${parent_engine}/${service_name}

chown -R ${user}.${group} /var/secrets/${container_type}s/${parent_engine}/${service_name}
chmod o-rxw /var/secrets/${container_type}s/${parent_engine}/${service_name}