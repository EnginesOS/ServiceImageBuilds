#!/bin/sh
cd /home/app
git pull
export RACK_ENV production
bundle install --standalone   


