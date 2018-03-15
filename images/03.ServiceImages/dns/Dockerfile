FROM  engines/servicebase:$release

RUN adduser -q --disabled-password --home /var/cache/bind -uid 22009 bind &&\
	apt-get -y update &&\
	apt-get -y install bind9 &&\
    mkdir -p /var/lib/bind/engines &&\
    mkdir -p /var/run/named &&\
    mkdir -p /home/bind/engines/zones/ &&\
    chown bind -R  /home/bind/ &&\
 	/home/engines/scripts/build/post_build_clean.sh
    

ADD src/named.conf.local /etc/bind/named.conf.local
ADD src/named.conf.options etc/bind/
ADD src/engines.internal.domain /var/lib/bind/engines/engines.dnsrecords

COPY sudoers /etc/sudoers.d/dns
COPY home home

RUN chown bind /var/run/named &&\
	chown bind /var/lib/bind/engines /home/bind/ &&\
	usermod -G containers -a bind &&\
	touch /home/bind/engines/forwarders &&\
	chown bind /home/engines/scripts/configurators/saved /home/bind/engines/forwarders &&\
	mkdir -p /etc/bind/keys/ /home/bind/engines/domains /home/bind/engines/zones/ &&\
	chown bind -R /etc/bind/keys/ /etc/bind/named.conf.default-zones  /var/lib/bind/engines/engines.dnsrecords /home/bind/engines/domains.hosted /home/bind/engines/zones/ /home/bind/engines/domains// &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER bind

RUN mkdir -p /home/bind/domain_list/lan /home/bind/domain_list/gw

ENV ContUser bind
ENV ContGrp bind

CMD ["/home/engines/scripts/system/start.sh"]