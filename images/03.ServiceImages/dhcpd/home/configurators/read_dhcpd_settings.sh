#!/bin/bash

if test -f /home/configurators/saved/dhcpd_settings
 then
  cat /home/configurators/saved/dhcpd_settings
else
  echo '{"dhcpd_settings":"Not Set"}'
fi
exit 0