#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=`mktemp`
parms_to_file_and_env
mkdir -p /home/ivpn/entries/site/${vpn_name}
cp $PARAMS_FILE /home/ivpn/entries/site/${vpn_name}/params
rm $PARAMS_FILE

function add_site_vpn {

cat /home/engines/templates/site2site.tmpl | while read LINE
do
 eval echo "$LINE" >> /home/ivpn/entries/site/${vpn_name}/entry
done

cat /home/engines/templates/site2site.tmpl | while read LINE
do
 eval echo "$LINE" >> /home/ivpn/entries/site/${vpn_name}/nat
done

 cat /home/engines/templates/secret.tmpl | while read LINE
do
 eval echo "$LINE" >> /home/ivpn/entries/site/${vpn_name}/secret
done
 
 

}

function set_encrypt_defaults {
if test -z $phase1_enc
 then
  phase1_enc=aes128
fi

if test -z $phase2_enc
 then
  phase2_enc=aes128
fi

if test -z $phase1_hash
 then
  phase1_hash=sha1
fi

if test -z $phase2_hash
 then
  phase2_hash=sha1
fi
if test -z $phase1_dh
 then
  phase1_dh=3072
fi

if ! test -z $pfs
 then
  pfs=-$pfs
fi

}
function set_local_default_values {
if test -z $local_id
 then
	local_id=domain=`cat /home/engines/etc/ssl/certs/ivpn.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"`
fi
if test -z $local_subnet
 then	
	local_subnet=`cat /home/engines/system/net/ip | awk -F. '{print $1"."$2"."$3".0/24" }'`
fi

}
function set_defaults {
  set_local_default_values
  set_encrypt_defaults
}

required_values="vpn_name remote_ip remote_id remote_subnet psk"
check_required_values
set_defaults
get_local_values  

add_site_vpn

sudo -n /home/engines/scripts/configurators/_add_site_vpn.sh "$vpn_name"
if test $? -eq 0
 then
	echo "Success"
	exit 0
else
  exit 1
fi	
