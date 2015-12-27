#!/bin/sh

cp /home/tmpl/duply_conf  $1
echo GPG_KEY='$key' >> $1
echo GPG_PW='' >> $1
