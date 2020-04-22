FROM engines/base:k
#FROM engines/base_image:alpha 
ADD home /home/

VOLUME /client/var/log
VOLUME /client/log
VOLUME /client/state
VOLUME /client/fs
VOLUME /dest/fs

RUN /usr/sbin/usermod -u 22671 www-data &&\
    addgroup  --gid 22672 ruby &&\
    addgroup  --gid 22674 python &&\
    addgroup  --gid 22673 node &&\
	useradd -u 22672  -g  ruby  -d /home/engines  -G  www-data  ruby &&\
	useradd -u 22674  -g  python  -d /home/engines -G  www-data  python &&\
	useradd -u 22673  -g  node  -d /home/engines -G  www-data  node 
	
CMD ["/home/setup_vols.sh"]

