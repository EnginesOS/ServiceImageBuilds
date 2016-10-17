#!/bin/bash

cat - >/home/configurators/saved/credentials

cat /home/configurators/saved/credentials | /home/engines/bin/json_to_env >/tmp/.env

 . /tmp/.env
exit 0
