#!/bin/bash
port=`cat /home/resources/config/next_port`
next_port=`expr $port + 1`
echo $next_port > /home/resources/config/next_port
echo $port