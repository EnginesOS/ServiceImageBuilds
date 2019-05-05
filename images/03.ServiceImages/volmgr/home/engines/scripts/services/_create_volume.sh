#!/bin/sh

mkdir -p /var/fs/local/${parent_engine}/${service_name}
chown -R ${user}.${group} /var/fs/local/${parent_engine}/${service_name}
chmod g+ws /var/fs/local/${parent_engine}/${service_name}
chmod o-rxw /var/fs/local/${parent_engine}/${service_name}
