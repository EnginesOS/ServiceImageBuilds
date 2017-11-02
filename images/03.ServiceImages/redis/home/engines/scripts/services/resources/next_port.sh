#!/bin/bash
port=`cat /home/redis/next_port`
next_port=`expr $port + 1`
echo $next_port > /home/redis/next_port
echo -n $port