#!/bin/bash

cat - | tar -xzpf -

while test -f /tmp/registry.lock
 do
  sleep 1
done
 
touch /tmp/registry.lock
cp /opt/engines/run/service_manager/services.yaml /opt/engines/run/service_manager/services.yaml.pre_restore
cp  /tmp/registry/backup.* /opt/engines/run/service_manager/services.yaml

rm /tmp/registry.lock