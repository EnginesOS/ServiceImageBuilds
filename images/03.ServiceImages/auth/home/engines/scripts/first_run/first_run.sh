#!/bin/sh

sudo -n /home/engines/scripts/first_run/sudo/_first_run.sh >/var/log/first_run.log
exit_code=$?

