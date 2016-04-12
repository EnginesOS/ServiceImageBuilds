FROM  engines/servicebase:$release


RUN echo "Y" |/usr/sbin/usermod -u  22012 syslog ;\
 	apt-get -y update;\
	apt-get upgrade -y;\
	/home/no_init.sh
	

 
ENV ContUser syslog
ENV ContGrp syslog

ADD home /home/

RUN chown syslog /home/configurators/saved /home/logrotate.d



USER 0
CMD ["/home/start.sh"]
