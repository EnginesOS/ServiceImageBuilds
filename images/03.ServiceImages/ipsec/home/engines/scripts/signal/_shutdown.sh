#!/bin/bash
PID_FILE=/tmp/ipsec.pid
kill -$1 ` cat $PID_FILE`
