#!/bin/sh


rm /home/avahi/hosts/*.${default_mdns_domain}
echo -n ${default_mdns_domain} >/home/engines/scripts/configurators/saved/default_mdns_domain

/home/engines/scripts/signal/kill_avahi.sh

exit 1
