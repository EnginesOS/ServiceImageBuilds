FROM engines/base_image:alpha 
ADD home /home/
VOLUME /client/var/log
VOLUME /client/log
VOLUME /client/state
VOLUME /client/fs
VOLUME /dest/fs
RUN	deluser www-data;\
	adduser   -uid 22671 --disabled-password www-data;\
	adduser  --group www-data --disabled-password -uid 22672 ruby;\
	adduser  --group www-data --disabled-password -uid 22673 node;\
	adduser  --group www-data --disabled-password -uid 22674 python
	
CMD ["/home/setup_vols.sh"]

