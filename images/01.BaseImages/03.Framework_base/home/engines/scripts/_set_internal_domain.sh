#!/bin/bash

cat /etc/krb5.conf | sed "/ENGINES\.INTERNAL/s//$1/" >/tmp/t
mv /tmp/t /etc/krb5.conf