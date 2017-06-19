#!/bin/bash

kill -HUP `cat  /tmp/publish.pid`
/home/publish_aliases.sh