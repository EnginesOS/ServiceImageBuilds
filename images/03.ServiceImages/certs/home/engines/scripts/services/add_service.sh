#!/bin/sh
. /home/certs/store/default_cert_details
 . /home/engines/functions/checks.sh

required_values="install_target container_type parent_engine common_name country state city organisation person"
check_required_values
cert_type=generated
export cert_type wild cert_usage container_type install_target parent_engine common_name country state city organisation person ca_name cert_usage
if $cert_usage = ca
 then
  /home/engines/scripts/engine/create_ca.sh
 else
  /home/engines/scripts/engine/create_cert.sh
fi 