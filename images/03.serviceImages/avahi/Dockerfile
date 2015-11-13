FROM  engines/servicebase:$release
RUN echo "Y" | adduser -q --disabled-password --home /home/avahi -uid 22026 avahi
#RUN  usermod avahi -u  22026 
RUN apt-get -y update;\
	/home/no_init.sh;\
	apt-get -y install syslogd avahi-daemon dbus python python-avahi;\
	apt-get clean;\
	mkdir /var/run/dbus/;\
	rm -f /var/run/dbus/pid;\
    chown avahi -R  /home/avahi/ /var/run/

COPY sudoers /etc/sudoers.d/avahi
COPY home home
RUN usermod -G containers -a avahi
	
USER avahi

ENV ContUser avahi
ENV ContGrp avahi

CMD ["/home/start.sh"]