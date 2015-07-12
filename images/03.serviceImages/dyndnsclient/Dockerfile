FROM engines/servicebase:$release


RUN adduser -q --disabled-password  dyndns -uid 22021;\
	apt-get -y update;\
	apt-get -y install ddclient syslogd ;\
	apt-get clean 
	

COPY home home
COPY dyndns.conf /home/dyndns/
COPY sudoers /etc/	
RUN chown dyndns -R /home/dyndns ;\
	chmod og-rw home/dyndns/dyndns.conf;\	
	groupadd -g 22020 containers;\
	usermod -G containers -a dyndns

ENV ContUser dyndns
ENV ContGrp dyndns
USER dyndns
CMD ["/home/init.sh"]