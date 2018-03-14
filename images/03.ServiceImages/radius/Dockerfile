FROM  engines/servicebase:$release

RUN /home/engines/scripts/build/no_init.sh &&\
	adduser -q --disabled-password --home /home/radius -uid 22034 freerad &&\
	usermod -G containers -a freerad &&\
	usermod -G containers -a freerad &&\
	apt-get -y install freeradius freeradius-ldap&&\
 	/home/engines/scripts/build/post_build_clean.sh
 	

COPY home home
COPY sudoers /etc/sudoers.d/radius


ENV HOME /home/radius/
ENV ContUser freerad

USER freerad

CMD ["/home/engines/scripts/startup/start.sh"]