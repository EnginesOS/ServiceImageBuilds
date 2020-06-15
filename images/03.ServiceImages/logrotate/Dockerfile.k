FROM  engines/servicebase:k

RUN /usr/sbin/usermod -u  22012 syslog &&\
	/home/engines/scripts/build/no_init.sh &&\
	 groupadd -g 22028 logrotate &&\
	 useradd -u 22028  -g logrotate -d /home/logrotate -m -G containers logrotate
 
ENV ContUser logrotate
ENV ContGrp logrotate

COPY sudoers /etc/sudoers.d/logrotate

ADD home /home/

RUN mkdir -p /home/engines/scripts/configurators/saved /home/logrotate.d /home/saved/ &&\
	chown logrotate /home/engines/scripts/configurators/saved /home/logrotate.d /home/saved/

USER logrotate

CMD ["/home/engines/scripts/system/start.sh"]
