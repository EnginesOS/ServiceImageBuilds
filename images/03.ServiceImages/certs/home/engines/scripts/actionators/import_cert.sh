#!/bin/sh
 . /home/engines/functions/checks.sh

required_values="certificate private_key"
check_required_values

. /home/engines/scripts/engine/cert_dirs.sh

mkdir -p $ImportedRoot/certs/ $ImportedRoot/keys/
echo $certificate > $ImportedRoot/certs/tmp.crt
echo $private_key > $ImportedRoot/keys/tmp.key


if ! test -z $password
 then
  openssl rsa -in $ImportedRoot/keys/tmp.key -out $ImportedRoot/keys/btmp.key -passin pass:${password}
  mv $ImportedRoot/keys/btmp.key $ImportedRoot/keys/tmp.key
fi

common_name=`cat $ImportedRoot/certs/tmp.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*\./s///"`

if test -z ${common_name}
 then
  echo Missing common_name
  rm $ImportedRoot/keys/tmp.key $ImportedRoot/certs/tmp.crt
  exit 127
fi

mv $ImportedRoot/keys/tmp.key $ImportedRoot/keys/${common_name}.key
mv $ImportedRoot/certs/tmp.crt $ImportedRoot/certs/${common_name}.crt

store=imported/${common_name}
export cert_name store install_target

if ! test -z ${install_target}
 then
   if $install_target=default
    then
     /home/engines/scripts/engine/set_default.sh all imported ${common_name}
    else      
     sudo -n /home/engines/scripts/engine/sudo/_install_target.sh ${install_target} imported ${common_name} ${common_name}
   fi  
fi
 
 exit 0