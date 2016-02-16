FROM  sumologic/collector:latest-syslog


RUN echo "Y" |/usr/sbin/usermod -u  22012 syslog ;\
 	apt-get -y update;\
	apt-get upgrade -y;\
	groupadd -g 22020 containers ;\
	usermod -G containers -a syslog

ENV ContUser syslog
ENV ContGrp syslog

ADD home /home/
ADD sudoers /etc/


RUN mkdir -p /home/configurators/saved ;\
	 chgrp containers /home/configurators/saved
USER syslog
CMD ["/home/start.sh"]