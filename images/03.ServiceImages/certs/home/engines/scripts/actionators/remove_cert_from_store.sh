#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh

 . /home/engines/functions/checks.sh

required_values="common_name cert_type"
check_required_values

if test $cert_type = generated
 then
 echo "Cant remove system generated certificate"
 exit   
 fi

resolve_cert_dir
resolve_key_dir
if ! test -f $cert_path/${common_name}.crt 
 then
   echo "No such cert  $cert_path/${common_name}.crt "
   exit 
fi

if test -f $cert_dir/${common_name}.key
 then
   sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh $cert_dir/${common_name}.crt 
     if test $? -ne 0
       then
         echo "Failed to Delete Cert $common_name"
          exit 127
     fi
 else
     echo "no such file $cert_dir/${common_name}.key"
      exit 127      
fi

if test -f $key_dir/${common_name}.key
  then
  sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh $key_dir/${common_name}.key
     if test $? -ne 0
      then
        echo "Failed to Delete Key $common_name"
        exit 127
     fi
 else
  echo "no such file $key_dir/${common_name}.key"
  exit 127
fi
    

exit 0
 	
