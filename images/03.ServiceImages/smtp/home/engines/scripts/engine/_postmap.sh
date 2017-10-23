#!/bin/bash
if ! test "/home/postfix/$1" 
 then
  touch "/home/postfix/$1" 
 fi 
cp "/home/postfix/$1" /etc/postfix/
postmap  /etc/postfix/"$1"   