#!/bin/sh
sudo -n /home/engines/scripts/engine/sudo/_fix_perms.sh
. /home/engines/scripts/engine/cert_dirs.sh

cert_name=`echo $common_name | sed "s/$.//"` 
export cert_name

#isUserCert=0
#if test -z $cert_type 
# then
#  cert_type=generated
#fi
#
#if test $cert_type = user
# then
#    cert_type=generated
#	StorePref=user
#	isUserCert=1
#  elif test $cert_type = external_ca
#  then
#   StorePref=/
#  else
#   StorePref=${container_type}s/${parent_engine}
#fi

 
if test -z $hostname
 then
  hostname=$common_name
fi

#if test -z $key_dir
# then
#    key_dir=$StoreRoot/$cert_type/keys/${StorePref}
#fi
#if test -z $cert_dir
# then
#    cert_dir=$StoreRoot/$cert_type/certs/${StorePref}
#fi


if ! test -d $key_dir
 then
  mkdir  -p $key_dir
fi
if ! test -d $cert_dir
then
 mkdir -p $cert_dir
fi
  
if ! test -d $setup_dir
 then
  mkdir -p $setup_dir
fi

if ! test -d $pending_csr_dir 
 then
  mkdir -p $pending_csr_dir
fi
 
 
if test -z $wild
 then
  wild="false"
fi

if test -z "$country" -a -z "$state" -a -z "$organisation"
 then
 . $StoreRoot/default_cert_details
fi

echo $country >$setup_dir/${cert_name}_setup
echo $state >>$setup_dir/${cert_name}_setup
echo $city >>$setup_dir/${cert_name}_setup
echo $organisation >>$setup_dir/${cert_name}_setup
echo $person >>$setup_dir/${cert_name}_setup

if test $wild = true
 then
  echo \*.$common_name >> $setup_dir/${cert_name}_setup
  alt_names="$alt_names  ${common_name}" 
  CN='\\*.'$common_name	
else
  CN=$common_name	
  echo $common_name >> $setup_dir/${cert_name}_setup
fi

 echo "" >>$setup_dir/${cert_name}_setup
if ! test $altName
 then
  	ALTNAME=DNS:$common_name
else
  	ALTNAME=DNS:$altName
fi
export ALTNAME=$ALTNAME

echo "" >>$setup_dir/${cert_name}_setup
echo "" >>$setup_dir/${cert_name}_setup
echo "" >>$setup_dir/${cert_name}_setup




cat /home/engines/templates/certs/request.template | sed -e "s/COUNTRY/$country/"  \
													-e "s/EMAIL/$email/"\
													-e "s/STATE/$state/" -e "s/ORGANISATION/$organisation/" \
													-e "s/PERSON/$person/" -e "s/COMMON_NAME/$CN/" \
													-e "s/HOSTNAME/$hostname/" >  $setup_dir/${cert_name}_config

n=2
if ! test -z "$alt_names"
 then
 	for alt_name in $alt_names
 	 do
 	  echo DNS.$n = $alt_name >> $setup_dir/${cert_name}_config
 	  n=`expr $n + 1`
 	done
fi

resolve_cert_dir
resolve_key_dir

cat /etc/ssl/openssl.cnf $setup_dir/${cert_name}_config >$setup_dir/${cert_name}_config_full
openssl genrsa -out  $key_dir/${cert_name}.key.tmp 2048

if ! test -f  $key_dir/${cert_name}.key.tmp
 then
  echo '{"status":"error","message":"Failed to create key ' $key_dir/${cert_name}.key'" }'
  exit 3
fi  


openssl req -new  -key $key_dir/${cert_name}.key.tmp -out $pending_csr_dir/${cert_name}.csr -config $setup_dir/${cert_name}_config

if ! test -f $pending_csr_dir/${cert_name}.csr 
  then
 	echo '{"status":"error","message":"Failed to Create CSR '$pending_csr_dir/${cert_name}.csr'"}'
 	rm  $key_dir/${cert_name}.key.tmp
 	exit 3
fi
 mv $key_dir/${common_name}.key.tmp $key_dir/${common_name}.key
