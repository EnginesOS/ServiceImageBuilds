#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="service_name"
check_required_values

rm /home/engines/etc/samba/smd.d/${service_name}.cf

sudo -n /home/engines/scripts/engine/rebuild_config_file.sh