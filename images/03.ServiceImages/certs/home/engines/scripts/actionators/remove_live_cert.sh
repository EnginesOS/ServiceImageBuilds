#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="common_name consumer_type consumer_name"
check_required_values

. /home/engines/scripts/engine/certs_dirs.sh


if test ${fqdn} = $consumer_name
 then
  echo '{"Result":"Failed","ErrorMesg":"Cannot remove default","ExitCode":"127"}'
  exit
fi 
if test -f $InstalledRoot/${consumer_type}s/${consumer_name}/certs/${common_name}.crt
 then
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/${consumer_type} ${consumer_name}/certs/${common_name}.crt
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/${consumer_type} ${consumer_name}/certs/store.${common_name}
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/${consumer_type} ${consumer_name}/keys/${common_name}.key
 else
   	echo '{"Result":"Failed","ErrorMesg":"No Such Cert '${fqdn}'","ExitCode":"127"}'
   	exit 0	
fi
echo '{"Result":"Success"}'
exit 0