#!/bin/sh
 . /home/engines/functions/checks.sh
required_values="fqdn"
check_required_values

. /home/engines/scripts/engine/cert_dirs.sh
 

if test -f $InstalledRoot/services/wap/certs/${fqdn}.crt
 then
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/service wap/certs/${fqdn}.crt
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/service wap/certs/store.${fqdn}
  sudo -n /home/engines/scripts/engine/_remove_cert.sh live/service wap/keys/${fqdn}.key
 else
   	echo '{"Result":"Failed","ErrorMesg":"No Such Cert '${fqdn}'","ExitCode":"127"}'
   	exit 0	
fi
echo '{"Result":"Success"}'
exit 0