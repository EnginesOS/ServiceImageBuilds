FROM  engines/servicebase:$release
#RUN echo "Y" | adduser -q --disabled-password --home /home/avahi -uid 22026 avahi
#RUN  
RUN apt-get -y update;\
	/home/no_init.sh;\
	apt-get -y install syslogd avahi-daemon dbus python python-avahi;\
	apt-get clean;\
	usermod avahi -u  22026 ;\	
	mkdir /var/run/dbus/;\
	rm -f /var/run/dbus/pid;\
    chown avahi -R   /var/run/ /etc/avahi/hosts

COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY sudoers /etc/sudoers.d/avahi
COPY home home
RUN usermod -G containers -a avahi;\
	mkdir -p /home/avahi/hosts/;\
	 chown avahi -R  /home/avahi/ /etc/avahi/avahi-daemon.conf
	
USER avahi

ENV ContUser avahi
ENV ContGrp avahi

CMD ["/home/start.sh"]