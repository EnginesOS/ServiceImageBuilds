#!/bin/sh
fn=/tmp/${common_name}.pkcs12

cert_type=user /home/engines/scripts/actionators/export_pkcs12.sh > $fn

smtp="smtp.engines.internal:25"
export smtp

echo "Here is your cert $common_name" | mailx -s "PKCS12 Cert" -r certs@$external_domain_name -A $fn $email_address 

rm /tmp/${common_name}.pkcs12