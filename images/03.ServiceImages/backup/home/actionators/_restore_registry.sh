#!/bin/bash
duply registry restore /tmp/registry $from_date

CURL_OPTS="-k -X PUT --header "Content-Type:application/octet-stream" --data-binary  @-"

cat /tmp/*registry* |curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/registry
rm -r /tmp/*registry*