#!/bin/sh

ca_name=external_ca
. /home/engines/scripts/engine/cert_dirs.sh

if test -f $pending_csr_dir/${csr_name}.csr
 then
  cat $pending_csr_dir/${csr_name}.csr | openssl req -noout -text
 else
  echo "No Such ${csr_name}"
   exit 1
fi
