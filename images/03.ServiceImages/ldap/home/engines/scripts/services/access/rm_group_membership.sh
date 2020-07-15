#!/bin/sh

LDIF_FILE=`mktemp`
LDAP_OUTF=`mktemp`

 cat /home/engines/templates/ldap/services/rm_group_membership.ldif | while read LINE
   do
     eval echo "$LINE" >> $LDIF_FILE
   done
   
echo "" >> $LDIF_FILE
echo "" >> $LDIF_FILE

cat $LDIF_FILE |sudo -n /home/engines/scripts/ldap/sudo/_ldapmodify.sh 2>&1 > $LDAP_OUTF
r=$?

if test $r -ne 0
 then 
  exit $r
fi
cp $LDIF_FILE /tmp/access
rm $LDIF_FILE