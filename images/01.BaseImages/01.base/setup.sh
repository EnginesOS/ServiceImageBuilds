#!/bin/sh
BuildDate=`date +%y%m%d`
export BuildDate

echo BuildDate=$BuildDate >.env
