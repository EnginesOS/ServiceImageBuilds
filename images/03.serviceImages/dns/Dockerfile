FROM  engines/servicebase:$release
RUN echo "Y" | adduser -q --disabled-password --home /var/cache/bind -uid 22009 bind

RUN apt-get -y update;\
	apt-get -y install bind9 syslogd;\
	apt-get clean;\
    mkdir -p /var/lib/bind/engines;\
    mkdir -p /var/run/named

ADD named.conf.local /etc/bind/named.conf.local
ADD named.conf.options etc/bind/
ADD templates /etc/bind/templates
COPY sudoers /etc/	
ADD engines.internal.domain /var/lib/bind/engines/engines.dnsrecords

RUN chown bind /var/run/named;\
	chown bind /var/lib/bind/engines;\
	usermod -G containers -a bind;\
	mkdir -p /etc/bind/keys/;\
	chown bind -R /etc/bind/keys/ /etc/bind/named.conf.default-zones
	
	
	
COPY home home
USER bind


ENV ContUser bind
ENV ContGrp bind

CMD ["/home/init.sh"]