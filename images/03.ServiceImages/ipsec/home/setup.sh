#/bin/bash
cp /engines/ssl/public/keys/ipvpn.key /etc/ipsec.d/private/
cp /engines/ssl/public/certs/ipvpn.crt /etc/ipsec.d/certs/  
cp /usr/local/share/ca-certificates/engines_internal_ca.crt  /etc/ipsec.d/cacerts/     

chmod og-rwx /etc/ipsec.d/private/ipvpn.key
 