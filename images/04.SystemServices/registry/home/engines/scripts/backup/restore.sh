#!/bin/bash

cat - | gzip -d > /tmp/registry_restored 

while test -f /tmp/registry.lock 
 do
  sleep 1
done
 
touch /tmp/registry.lock
cp /opt/engines/run/service_manager/services.yaml /opt/engines/run/service_manager/services.yaml.pre_restore
mv  /tmp/registry_restored /opt/engines/run/service_manager/services.yaml
kill -HUP `cat /home/engines/run/registry.pid`
rm /tmp/registry.lock