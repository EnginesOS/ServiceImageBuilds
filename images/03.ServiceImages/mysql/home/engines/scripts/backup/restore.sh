#!/bin/bash
#usage -y|n {section}  
#defaults to -n (delete existing data)
# -y will merge
 
echo $0 $1 $2 >/tmp/called
replace=$1
section=$2

#--replace
if ! test -z $replace
 then
  opts=--delete
 elif test $replace = -y
  then
   opts=--replace
  else
    opts=--delete
fi

if ! test -z $section
 then
 opts="$opts --one-database $section"
 fi
 
cat - | mysqlimport -B $opts -h 127.0.0.1 -u rma  


if test $? -ne 0
 then 
   cat  /tmp/restore.run
   exit 2
fi

mysqladmin -u rma flush-privileges
 
exit 0