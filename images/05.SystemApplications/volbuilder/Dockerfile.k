FROM engines/base_image:alpha 

ADD home /home/

VOLUME /client/var/log
VOLUME /client/log
VOLUME /client/state
VOLUME /client/fs
VOLUME /dest/fs

RUN /usr/sbin/usermod -u 22671 www-data &&\
	groupadd -g 22674 python &&\
	groupadd -g 22672 node  &&\
	useradd -u 22674  -g  python  -d /home/engines -G  www-data  python &&\
	useradd -u 22673  -g  node  -d /home/engines -G  www-data  node 
	
CMD ["/home/setup_vols.sh"]

