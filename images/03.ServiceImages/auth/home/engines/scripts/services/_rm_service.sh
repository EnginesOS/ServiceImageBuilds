#!/bin/bash
# FixME


. /home/engines/functions/params_to_env.sh
params_to_env

required_values="parent_engine container_type"
check_required_values

export parent_engine container_type

echo delprinc  host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local 
rm -r /etc/krb5kdc/services/$parent_engine 


echo "Success"
exit 0
