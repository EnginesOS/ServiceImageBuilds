#!/bin/bash

cat - | tar -xzpf -

while test -f /tmp/registry.lock
 do
  sleep 1
done
 
touch /tmp/registry.lock
cat /opt/engines/run/service_manager/services.yaml | gzip 
rm /tmp/registry.lock