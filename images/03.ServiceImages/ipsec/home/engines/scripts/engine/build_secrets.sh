#!/bin/sh
cp /home/engines/templates/ipsec.secrets.head /etc/ipsec.secrets
cat /home/ivpn/entries/users/*/secret >> /etc/ipsec.secrets
cat /home/ivpn/entries/sites/*/secret >> /etc/ipsec.secrets
chmod go-rwx /etc/ipsec.secrets
ipsec stroke rereadsecrets 