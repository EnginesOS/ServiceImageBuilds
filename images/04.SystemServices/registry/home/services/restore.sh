#!/bin/bash

cat - >/tmp/new_reg

while test -f /tmp/registry.lock
 do
  sleep 1
done
 
touch /tmp/registry.lock
cp /opt/engines/run/service_manager/services.yaml /opt/engines/run/service_manager/services.yaml.pre_restore
cp /tmp/new_reg /opt/engines/run/service_manager/services.yaml

rm /tmp/registry.lock