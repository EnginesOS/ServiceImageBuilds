#!/bin/sh
git branch | grep \* | cut -d ' ' -f2
exit 0
