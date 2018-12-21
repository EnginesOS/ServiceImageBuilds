FROM  engines/servicebase:$release

COPY home home

RUN useradd -u 22031  -g ivpn -d /home/ivpn -m -G containers ivpn&&\
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