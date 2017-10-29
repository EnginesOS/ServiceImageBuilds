#!/bin/sh
echo kill -$1 cat $2
 kill -$1 `cat $2`