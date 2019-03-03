#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh

if test -f $pending_csr_dir/${csr_name}.csr
 then
  cat $pending_csr_dir/${csr_name}.csr 
 else
  echo "No Such ${csr_name}"
   exit 1
fi
