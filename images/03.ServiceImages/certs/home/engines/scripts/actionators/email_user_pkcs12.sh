#!/bin/sh
fn=/tmp/${common_name}.p12

cert_type=user /home/engines/scripts/actionators/export_pkcs12.sh > $fn

smtp="smtp.engines.internal:25"
export smtp
if test -z $message
 then
  message="Here is your cert $common_name"
fi  

echo  "$message" | mailx -s "PKCS12 Cert" -r certs@$external_domain_name -A $fn $email_address 

rm /tmp/${common_name}.p12