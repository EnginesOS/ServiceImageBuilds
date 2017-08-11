#!/bin/sh

. /home/engines/functions/params_to_env.sh
parms_to_env

sudo -n /home/configurators/_set_password.sh "$password"