FROM  engines/servicebase:$release

COPY home home

RUN adduser -q --disabled-password --home /home/ivpn -uid 22031 ivpn &&\
	usermod -G containers -a ivpn &&\
	apt-get -y update &&\
	apt-get install -y strongswan libcharon-extra-plugins telnet strongswan-plugin-eap-mschapv2 strongswan-plugin-ldap strongswan-plugin-eap-radius moreutils 

COPY sudoers /etc/sudoers.d/ipsec

COPY src/ipsec.secrets /etc/
COPY src/strongswan.conf /etc/
COPY src/eap-radius.conf /etc/strongswan.d/charon/
RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER ivpn
	
ENV ContUser ivpn

CMD ["/home/engines/scripts/system/start.sh"]