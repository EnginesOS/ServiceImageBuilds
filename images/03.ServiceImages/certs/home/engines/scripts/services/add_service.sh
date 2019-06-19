#!/bin/sh
 . /home/engines/scripts/engine/cert_dirs.sh
 load_cert_defaults
 . /home/engines/functions/checks.sh
common_name=$cert_name
install_target=$container_type/$parent_engine
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