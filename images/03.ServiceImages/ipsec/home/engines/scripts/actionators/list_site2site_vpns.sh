#!/bin/sh


echo '{"Enabled":['
sites=`ls /home/ivpn/entries/sites/`
n=0
for site  in $sites
 do
    if test $n -ne 0
     then
      echo -n ','
    else
      n=1
    fi    
  echo '"'$site'"' 	
 done
 
echo '],"Disabled":[' 
if test -d /home/ivpn/entries/disabled_sites/
 then
  disabled_sites=`ls /home/ivpn/entries/disabled_sites/`
  n=0
  for site  in $disabled_sites
   do
      if test $n -ne 0
       then
        echo -n ','
      else
        n=1
      fi    
    echo  '"'$site'"'	
   done
fi
 echo ']}'