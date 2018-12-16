#!/bin/sh

if test $container_type = service
 then
  top=Services
 else
  top=Applications
fi    
ou_dn="cn=${cn},ou=${parent_engine},ou=$top,ou=Containers,ou=Engines,dc=engines,dc=internal"