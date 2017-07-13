#!/bin/bash
sudo -n duply registry restore /tmp/registry $from_date

tar -czpf - /tmp/system/*registry* |curl $CURL_OPTS https://172.17.0.1:2380/v0/restore/registry
rm -r /tmp/system/*registry*