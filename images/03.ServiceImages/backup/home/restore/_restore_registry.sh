#!/bin/bash


CURL_OPTS="-k -X PUT --header "Content-Type:application/octet-stream" --data-binary  @-"

cat /tmp/registry/backup.* |curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/registry/$replace/$section
echo "Restored registry $replace $source $section"
rm -r /tmp/registry