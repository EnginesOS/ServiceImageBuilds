FROM engines/servicebase:$release


RUN adduser -q --disabled-password  dyndns -uid 22021;\
	/home/no_init.sh ;\	
	apt-get  update;\
	apt-get -y install ddclient  inetutils-syslogd  ;\
 	/home/post_build_clean.sh

	

COPY home home
COPY sudoers /etc/sudoers.d/dyndns	

RUN chown dyndns -R /home/dyndns /var/cache/ddclient/ ;\
	groupadd -g 22020 containers;\
	usermod -G containers -a dyndns;\
	chown dyndns /home/configurators/saved

ENV ContUser dyndns
ENV ContGrp dyndns
USER dyndns
CMD ["/home/start.sh"]