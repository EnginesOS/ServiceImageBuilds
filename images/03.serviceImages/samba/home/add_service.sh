#!/bin/bash

service_hash=$1



#ssh auth@auth.engines.internal 

 ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i /home/.ssh/add_rsa auth@auth.engines.internal /home/auth/scripts/nfs/add_service.sh \'$service_hash\'
 

