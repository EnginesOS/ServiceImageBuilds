#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="fqdn consumer_type consumer_name"
check_required_values

if test ${fqdn} = $consumer_name
 then
  echo '{"Result":"Failed","ErrorMesg":"Cannot remove default","ExitCode":"127"}'
  exit
fi 
if test -f /home/certs/store/live/${consumer_type}s/${consumer_name}/certs/${fqdn}.crt
 then
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/${consumer_type} ${consumer_name}/certs/${fqdn}.crt
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/${consumer_type} ${consumer_name}/certs/store.${fqdn}
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/${consumer_type} ${consumer_name}/keys/${fqdn}.key
 else
   	echo '{"Result":"Failed","ErrorMesg":"No Such Cert '${fqdn}'","ExitCode":"127"}'
   	exit 0	
fi
echo '{"Result":"Success"}'
exit 0