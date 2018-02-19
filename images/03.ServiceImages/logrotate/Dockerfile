FROM  engines/servicebase:$release

RUN /usr/sbin/usermod -u  22012 syslog &&\
	/home/no_init.sh &&\
	 adduser --uid 22028 -q --home /home/logrotate --disabled-password logrotate &&\
	usermod -G containers -a logrotate
 
ENV ContUser logrotate
ENV ContGrp logrotate

COPY sudoers /etc/sudoers.d/logrotate

ADD home /home/

RUN mkdir -p /home/engines/scripts/configurators/saved /home/logrotate.d /home/saved/ &&\
	chown logrotate /home/engines/scripts/configurators/saved /home/logrotate.d /home/saved/

USER logrotate

CMD ["/home/engines/scripts/startup/start.sh"]
