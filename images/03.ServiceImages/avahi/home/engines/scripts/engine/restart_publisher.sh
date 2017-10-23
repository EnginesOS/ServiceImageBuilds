#!/bin/bash

kill -HUP `cat  /tmp/publish.pid`
/home/engines/scripts/engine/publish_aliases.sh