#!/bin/sh


. /home/engines/functions/system_functions.sh
service_first_run_check

sudo -n /home/engines/scripts/startup/_start.sh 	

