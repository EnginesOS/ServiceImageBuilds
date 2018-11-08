#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

sudo -n /home/engines/scripts/backup/engine/_backup.sh