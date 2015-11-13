FROM  engines/servicebase:$release
RUN  usermod avahi -u  22026 

RUN apt-get -y update;\
	/home/no_init.sh;\
	apt-get -y install avahi-daemon dbus python python-avahi;\
	apt-get clean;\
    chown avahi -R  /home/avahi/

COPY sudoers /etc/sudoers.d/avahi
COPY home home
RUN usermod -G containers -a avahi
	
USER avahi

ENV ContUser avahi
ENV ContGrp avahi

CMD ["/home/start.sh"]