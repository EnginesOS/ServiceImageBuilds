#!/bin/bash
 
 cat /home/cron/entries/*/* > /home/cron/spool/cron.orig
 /home/cron/bin/fcrontab -z