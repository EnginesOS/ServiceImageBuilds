#!/bin/sh
 . /home/engines/scripts/engine/cert_dirs.sh
 load_cert_defaults
 . /home/engines/functions/checks.sh
 if test -z $common_name
  then
    common_name=$cert_usage
 fi   
 if test -z $cert_usage
  then
    cert_usage=cert
 fi   
required_values="container_type parent_engine common_name country state city organisation person"
check_required_values
install_target=$container_type/$parent_engine
cert_type=generated
export cert_type wild cert_usage container_type install_target parent_engine common_name country state city organisation person ca_name cert_usage
if test $cert_usage = ca
 then
  /home/engines/scripts/engine/create_ca.sh
 else
  /home/engines/scripts/engine/create_cert.sh
fi 