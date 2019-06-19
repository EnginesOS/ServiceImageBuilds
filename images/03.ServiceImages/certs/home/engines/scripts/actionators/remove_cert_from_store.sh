#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh

 . /home/engines/functions/checks.sh

required_values="common_name cert_type ca_name"
check_required_values

. $cert_dir/${common_name}.meta

if test $cert_type = generated
 then
 echo "User Cant remove system generated certificate"
 exit 2  
fi

export common_name cert_dir cert_type ca_name key_dir
/home/engines/scripts/engine/remove_cert.sh
