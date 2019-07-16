#!/bin/bash
if ! test -f "/home/postfix/$1" 
 then
  if test -f "/home/engines/templates/$1"
   then
    cp "/home/engines/templates/$1" /home/postfix/
    chown postfix "/home/postfix/$1"
  else  
    touch "/home/postfix/$1"
    chown postfix "/home/postfix/$1"
  fi   
 fi 
cp "/home/postfix/$1" /etc/postfix/maps/

postmap  /etc/postfix/maps/"$1"   