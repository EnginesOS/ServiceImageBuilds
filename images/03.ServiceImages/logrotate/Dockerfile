FROM  engines/servicebase:$release


RUN echo "Y" |/usr/sbin/usermod -u  22012 syslog &&\
	/home/no_init.sh &&\
	 adduser --uid 22028 -q --home /home/logrotate --disabled-password logrotate &&\
	usermod -G containers -a logrotate
 
ENV ContUser logrotate
ENV ContGrp logrotate
COPY sudoers /etc/sudoers.d/logrotate

ADD home /home/

RUN mkdir -p /home/configurators/saved /home/logrotate.d /home/saved/ &&\
	chown logrotate /home/configurators/saved /home/logrotate.d /home/saved/




USER logrotate
ENV ContUser logrotate
CMD ["/home/start.sh"]
