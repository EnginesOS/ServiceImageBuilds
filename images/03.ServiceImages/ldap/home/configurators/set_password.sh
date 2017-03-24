#!/bin/sh
cat - | /home/engines/bin/json_to_env >/tmp/.env
. /tmp/.env

sudo -n /home/configurators/_set_password.sh $password