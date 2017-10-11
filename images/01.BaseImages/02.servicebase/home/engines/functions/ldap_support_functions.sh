function ldap_err_to_json_compat {
string_for_json=`echo $string_for_json | tr -d \r\"\f\b`
string_for_json=${string_for_json//\\/\\\\} # \ 
string_for_json=${string_for_json//\//\\\/} # / 
string_for_json=${string_for_json//\'/\\\'} # ' (not strictly needed ?)
string_for_json=${string_for_json//\"/\\\"} # " 
string_for_json=${string_for_json//	/\\t} # \t (tab)
}

function process_ldap_result {
 if test $result -eq 0
  then
     echo  '{"Result":"OK","ReturnCode":"0"}'
 else
     string_for_json=`cat /tmp/ldap.out | grep -v SASL `
     ldap_err_to_json_compat
     echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
 fi
  
exit $result

}