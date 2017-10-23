#!/bin/bash
cp "/home/email/$1" /etc/postfix/maps
postmap  /etc/postfix/maps/"$1"   