FROM  engines/servicebase:$release

RUN  adduser -q --disabled-password -uid 22037 clamav &&\
	/home/engines/scripts/build/no_init.sh &&\		
	apt-get update -y &&\
 	apt-get -y install clamsmtp  clamav-daemon &&\	
 	usermod -G containers -a clamav &&\
 	/home/engines/scripts/build/post_build_clean.sh

ENV ContUser clamav
ENV ContGrp clamav


ADD home /home/
ADD sudoers /etc/sudoers.d/syslog

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER clamav

CMD ["/home/engines/scripts/system/start.sh"]
