#!/bin/bash

/home/engines/scripts/ldapsearch.sh $1 $2 dn | grep dn: | cut -f2- -d: