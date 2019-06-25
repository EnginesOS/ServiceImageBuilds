#!/bin/sh

echo -n $1 > /home/engines/run/flags/current_backup
echo -n $2 > /home/engines/run/flags/current_operation
sudo -n duply $*
r=$?
rm /home/engines/run/flags/current_backup /home/engines/run/flags/current_operation
exit $r