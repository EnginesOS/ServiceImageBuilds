#/bin/bash
. /home/engines/functions/ldap/support_functions.sh
sudo -n /home/engines/scripts/ldap/sudo/_ldapdelete.sh $* &> /tmp/ldap.del.out
result=$?

process_ldap_result

