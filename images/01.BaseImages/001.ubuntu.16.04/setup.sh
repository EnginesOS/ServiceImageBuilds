#!/bin/sh

cp Dockerfile.$arch Dockerfile

BuildDate=`date +%y%m%d`
export BuildDate
echo BuildDate=$BuildDate >.env
EnginesRelease=`pwd | cut -d/ -f 5`
echo EnginesRelease=$EnginesRelease >> .env
