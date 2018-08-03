#!/bin/sh

cd /home/app
git branch | grep \* | cut -d ' ' -f2

exit 0
