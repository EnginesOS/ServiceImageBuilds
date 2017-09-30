#!/bin/bash
tar -cpf - /home/certs/store/ 2>/tmp/tar.errs
if test $? -ne 0
 then 
   cat  /tmp/tar.errs  >&2
   exit -1
fi
 
 exit 0