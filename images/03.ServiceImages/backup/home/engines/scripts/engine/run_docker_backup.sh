#!/bin/bash

echo $1 |\
 ssh -o UserKnownHostsFile=/dev/null \
 -o StrictHostKeyChecking=no \
 -i /home/.ssh/run_backup_on_engine \
 engines@mgmt.engines.internal \
 /opt/engines/scripts/run_backup_on_engine.sh