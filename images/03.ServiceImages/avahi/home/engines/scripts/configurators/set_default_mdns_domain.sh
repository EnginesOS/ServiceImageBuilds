#!/bin/bash

default_mdns_domain=`cat /home/engines/scripts/configurators/saved/default_mdns_domain`
rm /home/avahi/hosts/*.${default_mdns_domain}

cat - >/home/engines/scripts/configurators/saved/default_mdns_domain
/home/engines/scripts/signal/kill_avahi.sh

exit 1
