#!/bin/bash

if test -d /home/certs/store/public/certs/
 then
 cd /home/certs/store/public/certs/
 ls *.crt |sed "/\.crt/s///g"
 fi
  
