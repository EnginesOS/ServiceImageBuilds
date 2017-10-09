#!/bin/bash

/home/engines/scripts/ldapsearch.sh -b $1 $2 dn | grep dn: | awk -f1- -d: