#!/bin/sh

. /home/engines/functions/params_to_env.sh
parms_to_env

sudo -n /home/actionators/_set_domin_password.sh "$password"