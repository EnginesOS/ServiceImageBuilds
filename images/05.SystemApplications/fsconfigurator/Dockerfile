FROM engines/base_image:alpha 
ADD home /home/
VOLUME /client/var/log
VOLUME /client/log
VOLUME /client/state
VOLUME /client/fs
VOLUME /dest/fs
RUN /usr/sbin/usermod -u 22671 www-data &&\
	adduser  -q --ingroup www-data --disabled-password -uid 22672 ruby &&\
	adduser -q --ingroup www-data --disabled-password -uid 22673 node &&\
	adduser -q --ingroup www-data --disabled-password -uid 22674 python
	
CMD ["/home/setup_vols.sh"]

