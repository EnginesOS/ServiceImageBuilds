#!/bin/sh

 . /home/engines/functions/checks.sh
 required_values="innodb_buffer_pool_size"
check_required_values
cd /home/engines/scripts/configurators/saved

echo -n $innodb_buffer_pool_size > innodb_buffer_pool_size

/home/engines/scripts/engine/build_config.sh
