#!/bin/sh

echo '{"Enabled":['
users=`ls /home/ivpn/entries/user/`
n=0
for user  in $users
 do
    if test $n -ne 0
     then
      echo -n ','
    else
      n=1
    fi    
  echo '"'$user'"' 	
 done
 
echo '],"Disabled":[' 
if test -d /home/ivpn/entries/disabled_users/
 then
  disabled_users=`ls /home/ivpn/entries/disabled_users/`
  n=0
  for user  in $disabled_users
   do
      if test $n -ne 0
       then
        echo -n ','
      else
        n=1
      fi    
    echo =n '"'$user'"'	
   done
fi
 echo ']}'