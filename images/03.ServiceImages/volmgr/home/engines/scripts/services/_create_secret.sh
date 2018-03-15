#!/bin/sh


mkdir -p /var/secrets/${container_type/}${parent_engine}/


dd if=/dev/urandom count=16 bs=1  | od -h | awk '{ print $2$3$4$6$6$7$8$9}' >/var/secrets/${container_type}/${parent_engine}/${secret_name}

chown -R ${user}.${group} /var/secrets/${container_type}/${parent_engine}/
chmod o-rxw /var/secrets/${container_type}/${parent_engine}/ 