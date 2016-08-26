FROM engines/servicebase:$release


RUN adduser -q --disabled-password  dyndns -uid 22021;\
	apt-get -y update;\
	apt-get upgrade -y;\
	/home/no_init.sh ;\	
	apt-get -y install ddclient syslogd ;\
 	/home/post_build_clean.sh

	

COPY home home
COPY sudoers /etc/	
RUN chown dyndns -R /home/dyndns /var/cache/ddclient/ ;\
	groupadd -g 22020 containers;\
	usermod -G containers -a dyndns;\
	chown dyndns /home/configurators/saved

ENV ContUser dyndns
ENV ContGrp dyndns
USER dyndns
CMD ["/home/start.sh"]