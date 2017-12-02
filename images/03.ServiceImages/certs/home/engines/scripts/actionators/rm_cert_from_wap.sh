#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="fqdn"
check_required_values

if test -f /home/certs/store/services/wap/certs/${fqdn}.crt
 then
  sudo -n /home/engines/scripts/engines/_remove.sh service wap/certs/${fqdn}.crt
  sudo -n /home/engines/scripts/engines/_remove.sh service wap/keys/${fqdn}.key
 else
   	echo '{"Result":"Failed","ErrorMesg":"No Such Cert '${fqdn}'","ExitCode":"127"}'
   	exit 0	
fi
echo '{"Result":"Success"}'
exit 0