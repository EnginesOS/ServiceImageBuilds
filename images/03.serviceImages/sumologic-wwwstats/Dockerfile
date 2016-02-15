FROM  sumologic/collector:latest-syslog


RUN echo "Y" |/usr/sbin/usermod -u  22012 syslog ;\
 	apt-get -y update;\
	apt-get upgrade -y;\
	usermod -G containers -a syslog

ENV ContUser syslog
ENV ContGrp syslog
ADD syslog-ng.conf /etc/syslog-ng/
ADD home /home/
ADD sudoers /etc/
USER syslog

RUN chgrp containers /home/configurators/saved

CMD ["/home/start.sh"]