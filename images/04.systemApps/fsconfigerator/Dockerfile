FROM engines/base_image:alpha 
ADD home /home/
VOLUME /client/var/log
VOLUME /client/log
VOLUME /client/state
VOLUME /client/fs
VOLUME /dest/fs
RUN	deluser www-data;\
	adduser  -q -uid 22671 --disabled-password www-data;\
	adduser  -q --group www-data --disabled-password -uid 22672 ruby;\
	adduser -q --group www-data --disabled-password -uid 22673 node;\
	adduser -q --group www-data --disabled-password -uid 22674 python
	
CMD ["/home/setup_vols.sh"]

