#!/bin/bash

kill -HUP `cat  /tmp/publish.pid`
/home/engines/scripts/avahi/publish_aliases.sh