#!/bin/bash

service_hash=$1

#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

#ssh auth@auth.engines.internal 

echo \'$service_hash\'| ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i /home/ftpd/.ssh/add_rsa auth@auth.engines.internal /home/auth/scripts/ftp/add_service.sh 
 

