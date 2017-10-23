#!/bin/bash

postconf -e myhostname="$1"
echo "$1" > /etc/postfix/mailname