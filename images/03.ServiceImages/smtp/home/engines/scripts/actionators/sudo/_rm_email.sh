#!/bin/sh

if ! test -z $1
 then
  postsuper -d $1 
fi