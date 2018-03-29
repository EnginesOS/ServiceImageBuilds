#!/bin/sh

 cp /home/engines/templates/ipsec.secrets.head /etc/ipsec.secrets
 cat /home/ivpn/entries/user/* >> /etc/ipsec.secrets
 cat /home/ivpn/entries/site/*/secret >> /etc/ipsec.secrets
 chmod go-rwx /etc/ipsec.secrets
 
 
 cat /etc/ipsec.head /home/ivpn/entries/site/${vpn_name}/entry >> /etc/ipsec.conf
 
 

