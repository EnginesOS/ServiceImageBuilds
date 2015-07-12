#!/bin/bash


service_hash=$1

#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i /home/nfs/.ssh/rm_rsa auth@auth.engines.internal /home/auth/scripts/nfs/rm_service.sh $service_hash