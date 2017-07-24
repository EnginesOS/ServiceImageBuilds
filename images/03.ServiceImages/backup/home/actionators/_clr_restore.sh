#!/bin/bash

restore_name=`echo $` |sed "/[ ;\\\'\"]/s///g"`

rm -r /tmp/$restore_name

exit 0