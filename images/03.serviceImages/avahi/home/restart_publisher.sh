#!/bin/bash


kill -HUP `cat  /tmp/publish.pid`
/home/publisher_aliases.sh