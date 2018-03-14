FROM  engines/servicebase:$release

RUN /usr/sbin/usermod -u 22012 syslog &&\
	/home/engines/scripts/build/no_init.sh &&\		
	apt-get update -y &&\
 	apt-get -y install syslog-ng-core \
 					   syslog-ng &&\
 	mkdir -p /home/rlog/ &&\
 	chown syslog /var/lib/syslog-ng/ &&\
 	usermod -G containers -a syslog &&\
 	/home/engines/scripts/build/post_build_clean.sh

ENV ContUser syslog
ENV ContGrp syslog

ADD src/syslog-ng.conf /etc/syslog-ng/
ADD home /home/
ADD sudoers /etc/sudoers.d/syslog

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER syslog

CMD ["/home/engines/scripts/startup/start.sh"]
