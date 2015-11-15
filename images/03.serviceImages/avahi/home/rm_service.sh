#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

if test -z ${hostname}
	then
		echo Error:Missing hostname
        exit 128
    fi


	rm /home/avahi/hosts/${hostname}
	
	/home/restart_publisher.sh
  
		echo Success
		exit 0

	
