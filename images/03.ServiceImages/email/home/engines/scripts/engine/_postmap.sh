#!/bin/bash
if ! test -f "/home/email/$1" 
 then
  touch "/home/email/$1" 
 fi 
cp "/home/email/$1" /etc/postfix/
postmap  /etc/postfix/"$1" 