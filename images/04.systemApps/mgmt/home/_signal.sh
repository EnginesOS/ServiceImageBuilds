#!/bin/sh

sudo kill -$1 `cat $2`
rm $PID_FILE