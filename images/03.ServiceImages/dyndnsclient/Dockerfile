FROM engines/servicebase:$release

RUN adduser -q --disabled-password  dyndns -uid 22021 &&\
	/home/no_init.sh &&\	
	apt-get  update &&\
	apt-get -y install ddclient &&\
 	/home/post_build_clean.sh

COPY home home
#COPY sudoers /etc/sudoers.d/dyndns	

RUN chown dyndns -R /home/dyndns /var/cache/ddclient/ &&\
	usermod -G containers -a dyndns &&\
	chown dyndns /home/engines/scripts/configurators/saved/
	#&&\
	#chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV ContUser dyndns
ENV ContGrp dyndns

USER dyndns

CMD ["/home/engines/scripts/system/start.sh"]