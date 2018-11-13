#!/bin/bash


#export  PGPASSWORD=$dbpasswd

pg_dumpall  

if test $? -ne 0
 then 
    export  PGPASSWORD=''
 	exit -1
fi
# export  PGPASSWORD=''
 exit 0
