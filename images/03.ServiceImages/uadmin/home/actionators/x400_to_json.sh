#!/bin/bash

function ldap_to_json {

echo '['

start=1
first=1
echo $x400string

echo "----"
for fld in $x400string
 do
 if test $start -eq 1
  then
   name=`echo $fld |sed "/:/s///"`
   start=0
    if test $name = dn
    then
     new_entry=1
    else
      new_entry=0
 fi
  else
   val=$fld
   start=1
if test $new_entry -eq 1
 then
 if test $first -eq 1
 then
  echo '{'
 first=0
 else
   echo '},{'
 fi
else
 echo ","
fi
echo   '"'$name'":"'$val'"'
 fi
#echo F $fld
done
echo '}]'

}