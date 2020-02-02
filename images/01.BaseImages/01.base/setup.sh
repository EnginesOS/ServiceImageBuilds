#!/bin/sh
BuildDate=`date +%y%m%d`
export BuildDate
release=`cat ../../../release`
echo export BuildDate=$BuildDate >.env
echo ENV	build ${BuildDate} >> Dockerfile.$release