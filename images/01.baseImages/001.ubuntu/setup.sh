#!/bin/bash

#should check md5
if  test ! -f ubuntu-14.04-server-cloudimg-amd64.tar.gz
	then
		wget http://cloud-images.ubuntu.com/releases/14.04/release/ubuntu-14.04-server-cloudimg-amd64.tar.gz
fi