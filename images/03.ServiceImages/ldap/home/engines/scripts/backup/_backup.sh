#!/bin/bash
kill -TERM ` cat /var/run/slapd.pid /var/run/saslauthd.pid`
slapcat 
