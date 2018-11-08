#!/bin/sh

if test $container_type = service
 then
  top=Services
 else
  top=Applications
fi    
group_dn="cn=${cn},ou=${parent_engine},ou=$top,ou=Groups,dc=engines,dc=internal"