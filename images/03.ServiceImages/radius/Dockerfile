FROM  engines/servicebase:$release

RUN /home/no_init.sh &&\
	adduser -q --disabled-password --home /home/radius -uid 22034 radius &&\
	usermod -G containers -a radius &&\
	apt-get -y install freeradius freeradius-ldap&&\
 	/home/post_build_clean.sh

COPY home home
COPY sudoers /etc/sudoers.d/radius


ENV HOME /home/radius/
ENV ContUser radius

USER radius

CMD ["/home/engines/scripts/system/start.sh"]