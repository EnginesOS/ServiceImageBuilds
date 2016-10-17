FROM engines/servicebase:$release
#FM  sumologic/collector:latest-syslog


RUN echo "Y" |/usr/sbin/usermod -u  22012 syslog ;\
 	apt-get -y update;\
	wget -q -O /tmp/collector.deb https://collectors.sumologic.com/rest/download/deb/64 && \
 	dpkg -i /tmp/collector.deb && \
 	rm /tmp/collector.deb && \	
	usermod -G containers -a syslog;\
 	/home/post_build_clean.sh

ENV ContUser syslog
ENV ContGrp syslog

ADD home /home/
ADD sudoers /etc/


RUN mkdir -p /home/configurators/saved ;\
	chmod g+w /home/configurators/saved ;\
	 chgrp containers /home/configurators/saved ;\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER syslog
ENV ContUser syslog
CMD ["/home/start.sh"]