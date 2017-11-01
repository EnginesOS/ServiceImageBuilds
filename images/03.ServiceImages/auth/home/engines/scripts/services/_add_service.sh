#!/bin/bash

function gen_service_key {
echo addprinc -randkey host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local 
mkdir /etc/krb5kdc/services/$parent_engine 
echo ktadd -k /etc/krb5kdc/services/$parent_engine/$parent_engine.keytab host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local 
}
gen_service_key

echo "Success"
exit 0
