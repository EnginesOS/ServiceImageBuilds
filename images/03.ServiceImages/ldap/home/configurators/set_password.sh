#!/bin/sh
cat - | /home/engines/bin/json_to_env >/tmp/.env
. /tmp/.env

/home/configurators/_set_password $password