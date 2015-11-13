#!/bin/bash

cd /home/avahi/hosts

/home/avahi-alias.py `ls ` &
PUBLISHER_PID=$%
echo $PUBLISHER_PID >/tmp/publish.pid
