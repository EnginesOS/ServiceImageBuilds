FROM engines/servicebase:k

RUN groupadd -g  22021 dyndns &&\
	useradd -u 22021  -g dyndns -d /home/dyndns -m -G containers dyndns&&\
	/home/engines/scripts/build/no_init.sh &&\	
	apt-get  update &&\
	apt-get -y install ddclient &&\
 	/home/engines/scripts/build/post_build_clean.sh

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