#!/bin/sh
cert_type=user
/home/engines/scripts/actionators/email_pkcs12.sh >/tmp/tt
smtp="smtp.engines.internal:25"
export smtp
echo "Here is your cert" | mailx -s "PKCS12 Cert" -r certs@$external_domain_name -A /tmp/tt $email_address 