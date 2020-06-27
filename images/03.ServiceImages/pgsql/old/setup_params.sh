#!/bin/bash

n=1


service_hash="$1"


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env
        
su postgres -c psql  "alter user rma with PASSWORD '$pgsql_password';"
