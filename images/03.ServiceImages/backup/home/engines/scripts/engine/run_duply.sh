#!/bin/bash

echo -n $1 > /engines/var/run/flags/current_backup
echo -n $2 > /engines/var/run/flags/current_operation
sudo -n duply $*
r=$?
rm /engines/var/run/flags/current_backup /engines/var/run/flags/current_operation
exit $r