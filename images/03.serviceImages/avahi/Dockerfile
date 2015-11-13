FROM  engines/servicebase:$release
RUN echo "Y" | adduser -q --disabled-password --home /home/avahi -uid 22026 avahi

RUN apt-get -y update;\
	apt-get -y install avahi-daemon dbus python python-avahi;\
	apt-get clean;\
    chown bind -R  /home/avahi/

COPY sudoers /etc/sudoers.d/avahi
COPY home home
RUN usermod -G containers -a avahi
	
USER avahi

ENV ContUser bind
ENV ContGrp bind

CMD ["/home/start.sh"]