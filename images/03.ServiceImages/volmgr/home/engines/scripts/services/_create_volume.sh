#!/bin/bash

mkdir -p /var/fs/local/${parent_engine}/${service_name}
chown -R ${user}.${group} /var/fs/local/${parent_engine}/${service_name}
chgrp ${group} /var/fs/local/${parent_engine}/${service_name}
