#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="service_name owner volume_service ro_access"
check_required_values

cat /home/engines/templates/smb.conf.service.tmpl | while read LINE
do
 eval echo "$LINE" >> /home/engines/etc/samba/smd.d/${service_name}.cf
done

sudo -n /home/engines/scripts/engine/rebuild_config_file.sh
