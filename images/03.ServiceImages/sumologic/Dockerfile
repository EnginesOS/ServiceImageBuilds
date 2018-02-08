FROM engines/servicebase:$release

RUN /usr/sbin/usermod -u 22012 syslog &&\
 	apt-get -y update &&\
	wget -q -O /tmp/collector.deb https://collectors.sumologic.com/rest/download/deb/64 &&\
 	dpkg -i /tmp/collector.deb &&\
 	rm /tmp/collector.deb &&\	
	usermod -G containers -a syslog &&\
 	/home/post_build_clean.sh

ENV ContUser syslog
ENV ContGrp syslog

ADD home /home/
ADD sudoers /etc/sudoers.d/sumologic

RUN mkdir -p /home/engines/scripts/configurators/saved &&\
	chmod g+w /home/engines/scripts/configurators/saved &&\
	chgrp containers /home/engines/scripts/configurators/saved &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER syslog

CMD ["/home/engines/scripts/system/start.sh"]