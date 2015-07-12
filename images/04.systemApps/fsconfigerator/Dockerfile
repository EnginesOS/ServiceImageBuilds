FROM busybox
ADD home /home/
VOLUME /client/var/log
VOLUME /client/log
VOLUME /client/state
VOLUME /client/fs
VOLUME /dest/fs
RUN	deluser www-data;\
	adduser   -u 22671 -D www-data;\
	adduser  -G www-data -u 22672 -D ruby;\
	adduser  -G www-data -u 22673 -D node;\
	adduser  -G www-data -u 22674 -D python
	
CMD ["/home/setup_vols.sh"]