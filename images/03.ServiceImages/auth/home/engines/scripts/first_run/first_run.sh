#!/bin/sh

sudo -n /home/engines/scripts/first_run/_first_run.sh >/var/log/first_run.log
touch /home/engines/run/flags/first_just_run
exit_code=$?
