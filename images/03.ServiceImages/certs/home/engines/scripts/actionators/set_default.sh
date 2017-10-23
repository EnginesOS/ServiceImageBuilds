#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

if test -z ${cert_name}
 then
  echo Missig cert_name
  exit 255
fi
 
 if test -z ${store}
 then
  echo Missing store
  exit 255
fi

 if test -z ${target}
 then
  echo Missing target
  exit 255
fi

sudo -n  /home/engines/scripts/engine/_install_target.sh ${target} ${store}/${cert_name} default