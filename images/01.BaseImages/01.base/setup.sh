#!/bin/sh
BuildDate=`date +%y%m%d`
export BuildDate

echo export BuildDate=$BuildDate >.env
