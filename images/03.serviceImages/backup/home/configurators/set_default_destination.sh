#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_destination

. /home/engines/scripts/functions.sh

load_service_hash_to_environment