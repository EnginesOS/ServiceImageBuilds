#!/bin/bash


rm /home/avahi/hosts/*

cat - >/home/engines/scripts/configurators/saved/default_mdns_domain
/home/engines/scripts/signal/kill_avahi.sh

exit 2
