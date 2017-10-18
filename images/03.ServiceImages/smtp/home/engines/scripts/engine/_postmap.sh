#!/bin/bash
cp "/home/postfix/$1" /etc/postfix/
postmap  /etc/postfix/"$1"   