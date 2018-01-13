#!/bin/bash
echo chown ${user}.${group} /var/fs/local/${parent_engine}/${service_name} >/tmp/cmd
chown ${user}.${group} /var/fs/local/${parent_engine}/${service_name}