#!/bin/bash

mkdir -p /var/fs/local/$1/$2
chown -R $3.$4 /var/fs/local/$1/$2

