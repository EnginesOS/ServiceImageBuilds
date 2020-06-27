#!/bin/sh

apt-get -y clean 
apt-get  -y autoremove 
apt-get  -y autoclean 		
rm -rf /tmp/*