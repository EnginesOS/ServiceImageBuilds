FROM  engines/servicebase:$release


RUN echo "Y" |/usr/sbin/usermod -u  22012 syslog ;\
	/home/no_init.sh ;\	
 	apt-get -y install syslog-ng-core syslog-ng ;\
 	mkdir -p /home/rlog/;\
 	chown syslog /var/lib/syslog-ng/ ;\
 	usermod -G containers -a syslog;\
 	/home/post_build_clean.sh
#


		 

ENV ContUser syslog
ENV ContGrp syslog
ADD syslog-ng.conf /etc/syslog-ng/
ADD home /home/
ADD sudoers /etc/
USER syslog
CMD ["/home/start.sh"]
