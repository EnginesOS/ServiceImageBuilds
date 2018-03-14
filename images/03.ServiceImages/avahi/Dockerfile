FROM  engines/servicebase:$release

RUN /home/engines/scripts/build/no_init.sh &&\
	apt-get -y update &&\
	apt-get -y install avahi-daemon \
	                   dbus \
	                   python \
	                   python-avahi &&\
	/home/engines/scripts/build/post_build_clean.sh &&\
	usermod avahi -u 22026 &&\	
	mkdir /var/run/dbus/ &&\
	rm -f /var/run/dbus/pid &&\
    chown avahi -R /var/run/ /etc/avahi/hosts

COPY src/avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY sudoers /etc/sudoers.d/avahi
COPY home home

RUN usermod -G containers -a avahi &&\
	mkdir -p /home/avahi/hosts/ &&\
	chown avahi -R /home/avahi/ /etc/avahi/avahi-daemon.conf &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	
USER avahi

ENV ContUser avahi
ENV ContGrp avahi

CMD ["/home/engines/scripts/startup/start.sh"]