#!/bin/bash

restore_name=`echo $1 |sed "/[ ;\\\'\"]/s///g"`

rm -r /tmp/$restore_name

exit 0