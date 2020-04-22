FROM  engines/servicebase:k

RUN groupadd -g 22037 clamav &&\
	useradd -u 22037  -g clamav -d /home/clamav -m -G containers clamav &&\
	/home/engines/scripts/build/no_init.sh &&\		
	apt-get update -y &&\
 	apt-get -y install clamsmtp  clamav-daemon &&\	
 	/home/engines/scripts/build/post_build_clean.sh &&\
	mkdir -p /var/run/clamav &&\
	chown clamav /var/run/clamav
ENV ContUser clamav
ENV ContGrp clamav


ADD home /home/
ADD sudoers /etc/sudoers.d/clamav

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER clamav

CMD ["/home/engines/scripts/system/start.sh"]
