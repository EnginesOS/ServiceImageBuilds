#!/bin/bash

LDAP_FILE=`mktemp`


function ldap_to_json_array {

echo '['

start=1
first=1
if test -s $LDAP_FILE
 then
  cat $LDAP_FILE | while read LINE
   do
   name=` echo $LINE | cut -f1 -d:`
   value=`echo $LINE | cut -f2- -d: |sed "/^[ ]/s///"`
    if test $name = dn
     then
       new_entry=1
     else
       new_entry=0
     fi
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
   echo   '"'$name'":"'$value'"'
  done
  echo '}'
fi
echo ']'
rm $LDAP_FILE
}


function ldap_to_json {
start=1
first=1 
if test -s $LDAP_FILE
 then
   cat $LDAP_FILE | while read LINE
    do
     name=` echo $LINE | cut -f1 -d:`
     value=`echo $LINE | cut -f2- -d: |sed "/^[ ]/s///"`
      if test $first -eq 1
       then
        echo '{'
        first=0
      else
        echo ","
      fi
      if ! test -z $line
       then 
         echo $line
       fi
    line='"'$name'":"'$value'"'
   done
   echo $line
  echo '}'
else
  echo '""'
fi
rm $LDAP_FILE
}


function map_ldap_to_json_array {
first=1
echo '['
if test -s $LDAP_FILE
 then
  cat $LDAP_FILE | while read LINE
   do
#echo LINE $LINE
    name=` echo $LINE | cut -f1 -d:`
    value=`echo $LINE | cut -f2- -d: |sed "/^[ ]/s///"`
#echo NVP _${name}_  $value
      if test "$name" = $key
        then
          if test $first -eq 1
           then
            first=0
          else
            echo ","
          fi
        echo   '"'$value'"'
     fi
  done
fi
echo ']'
rm $LDAP_FILE
}
