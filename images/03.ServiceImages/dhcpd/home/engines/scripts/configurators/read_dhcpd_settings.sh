#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/dhcpd_settings
 then
  cat /home/engines/scripts/configurators/saved/dhcpd_settings
else
  echo '{"dhcpd_settings":"Not Set"}'
fi
exit 0