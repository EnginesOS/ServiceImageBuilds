#!/bin/bash

LDAP_FILE=`mktemp`
#function ldap_to_json_array {
#
#echo '['
#
#start=1
#first=1
#
#for fld in $x400string
# do
# if test $start -eq 1
#  then
#   name=`echo $fld |sed "/:/s///"`
#   start=0
#    if test $name = dn
#    then
#     new_entry=1
#    else
#      new_entry=0
# fi
#  else
#   val=$fld
#   start=1
#if test $new_entry -eq 1
# then
# if test $first -eq 1
# then
#  echo '{'
# first=0
# else
#   echo '},{'
# fi
#else
# echo ","
#fi
#echo   '"'$name'":"'$val'"'
# fi
#done
#echo '}]'
#
#}


function ldap_to_json_array {

echo '['

start=1
first=1
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
echo '}]'
rm $LDAP_FILE
}
#function ldap_to_json {
#start=1
#first=1 
#
#
#for fld in $x400string
# do
# if test $start -eq 1
#  then
#   name=`echo $fld |sed "/:/s///"`
#   start=0   
#  else
#   val=$fld
#   start=1
#    if test $first -eq 1
#      then
#        echo '{'
#        first=0
#      else
#        echo ","
#    fi
#echo   '"'$name'":"'$val'"'
# fi
#done
#echo '}'
#}

function ldap_to_json {
start=1
first=1 
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
echo   '"'$name'":"'$value'"'
done
echo '}'
rm $LDAP_FILE
}

#function map_ldap_to_json_array {
#start=1
#first=1
#echo '['
#
#for fld in $x400string
# do
# if test $start -eq 1
#  then
#   name=`echo $fld |sed "/:/s///"`
#   start=0   
# else
#   val=$fld
#   start=1
#    if test $name = $key
#     then
#       if test $first -eq 1
#        then
#         first=0
#       else
#         echo ","
#       fi    
#      echo   '"'$val'"'
#    fi
# fi
#done
#
#echo ']'
#}

function map_ldap_to_json_array {
first=1
echo '['

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
echo ']'
rm $LDAP_FILE
}
