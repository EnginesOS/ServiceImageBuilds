#!/bin/bash

kill -HUP `cat  /home/engines/run/publish.pid`
/home/engines/scripts/engine/publish_aliases.sh