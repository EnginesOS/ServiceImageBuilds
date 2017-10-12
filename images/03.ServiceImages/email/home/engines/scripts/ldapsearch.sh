#/bin/bash
. /home/engines/functions/ldap_support_functions.sh

sudo /home/engines/scripts/sudo/_ldapsearch.sh "$1" $2 $3 $4 $5 $6 $7 $8  2> /tmp/ldap.err
result=$?

	if test $result -eq 0
	then
	 cat  $LDAP_OUTF
	else 
     string_for_json=`cat /tmp/ldap.err | grep -v SASL `
     ldap_err_to_json_compat
    echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
    exit $result
  fi
  


