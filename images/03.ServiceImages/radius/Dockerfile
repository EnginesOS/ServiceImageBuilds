FROM  engines/servicebase:$release

RUN /home/engines/scripts/build/no_init.sh &&\
	useradd -u 22034  -g freerad -d /home/radius -m -G containers freerad &&\
	apt-get -y install freeradius freeradius-ldap freeradius-krb5&&\
 	/home/engines/scripts/build/post_build_clean.sh
 	

COPY home home
COPY sudoers /etc/sudoers.d/radius
COPY src/eap.conf /etc/freeradius/
COPY src/users /etc/freeradius/
COPY src/radiusd.conf /etc/freeradius/
COPY src/proxy.conf /etc/freeradius/
COPY src/ldap /etc/freeradius/modules
COPY src/default_site /etc/freeradius/sites-available/default
COPY src/inner-tunnel /etc/freeradius/sites-available/inner-tunnel 

ENV HOME /home/radius/
ENV ContUser freerad

USER freerad

CMD ["/home/engines/scripts/system/start.sh"]