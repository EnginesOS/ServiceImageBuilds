#!/bin/sh

password=$2
current_password=$1



cat /home/tmpls/root_password.ldif | sed "/PASSWORD/s//$password/" >/tmp/chconfigpwg
lpdapmodify -Y EXTERNAL -H ldapi:/// -f /tmp/chconfigpwg
rm /tmp/chconfigpwg

 ldappasswd -D cn=admin,dc=engines,dc=internal -H ldapi:/// -s $password



