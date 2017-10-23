#!/bin/bash
cp "/home/email/$1" /etc/postfix/
postmap  /etc/postfix/"$1"   