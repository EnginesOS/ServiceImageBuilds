#!/bin/sh

cp Dockerfile.$arch Dockerfile

BuildDate=`date +%y%m%d`
export BuildDate
echo BuildDate=$BuildDate >.env
