#!/bin/bash
#http://cloud-images.ubuntu.com/bionic/20181219/bionic-server-cloudimg-amd64.tar.gz
#should check md5
if  test ! -f bionic-server-cloudimg-amd64.tar.gz
	then
		wget http://cloud-images.ubuntu.com/bionic/20181219/bionic-server-cloudimg-amd64.tar.gz
fi