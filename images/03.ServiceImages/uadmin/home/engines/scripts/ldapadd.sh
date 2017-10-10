#/bin/bash

function ascii_to_json_compat {
string_for_json=${string_for_json//\\/\\\\} # \ 
string_for_json=${string_for_json//\//\\\/} # / 
string_for_json=${string_for_json//\'/\\\'} # ' (not strictly needed ?)
string_for_json=${string_for_json//\"/\\\"} # " 
string_for_json=${string_for_json//   /\\t} # \t (tab)
#string_for_json=${string_for_json//
#/\\\n} # \n (newline)
#string_for_json=${string_for_json//^M/\\\r} # \r (carriage return)
#string_for_json=${string_for_json//^L/\\\f} # \f (form feed)
#string_for_json=${string_for_json//^H/\\\b} #
}

sudo /home/engines/scripts/sudo/_ldapadd.sh $* &> /tmp/ldap.add.out
result=$?
if test $result -eq 0
 then
  echo  '{"Result":"OK","ReturnCode":"0"}'
 else
     string_for_json=`cat /tmp/ldap.add.out`
     ascii_to_json_compat
    '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
  fi
  
exit $result
