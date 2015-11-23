FROM  engines/servicebase:$release
RUN echo "Y" | adduser -q --disabled-password --home /var/cache/bind -uid 22009 bind

RUN apt-get -y update;\
	apt-get -y install bind9 syslogd;\
	apt-get clean;\
    mkdir -p /var/lib/bind/engines;\
    mkdir -p /var/run/named ;\
    mkdir -p /home/bind/engines/zones/ ;\
    chown bind -R  /home/bind/

ADD named.conf.local /etc/bind/named.conf.local
ADD named.conf.options etc/bind/

ADD templates /etc/bind/templates
COPY sudoers /etc/	
ADD engines.internal.domain /var/lib/bind/engines/engines.dnsrecords
COPY home home
RUN chown bind /var/run/named;\
	chown bind /var/lib/bind/engines /home/bind/;\
	usermod -G containers -a bind;\
	mkdir -p /etc/bind/keys/ /home/bind/engines/domains /home/bind/engines/zones/;\
	chown bind -R /etc/bind/keys/ /etc/bind/named.conf.default-zones  /var/lib/bind/engines/engines.dnsrecords /home/bind/engines/domains.hosted /home/bind/engines/zones/ /home/bind/engines/domains/
	
	
	

RUN /home/setup.sh 
USER bind

RUN mkdir -p /home/bind/domain_list/lan /home/bind/domain_list/gw


ENV ContUser bind
ENV ContGrp bind

CMD ["/home/start.sh"]