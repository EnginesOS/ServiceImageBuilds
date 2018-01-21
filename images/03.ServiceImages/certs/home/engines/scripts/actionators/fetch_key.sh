#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="key_name store cert_type"
check_required_values


if test -f /home/certs/store/$cert_type/keys/${store}/${key_name}.key
  then
 	cat /home/certs/store/$cert_type/keys/${store}/${key_name}.key
  else
 	echo "Not Such key $cert_type/${store}/${key_name}.key"
 	exit 127
fi

exit 0
