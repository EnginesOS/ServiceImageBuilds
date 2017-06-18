FROM  engines/servicebase:$release

COPY home home

RUN  echo "Y" | adduser -q --disabled-password --home /home/ivpn -uid 22016 ivpn &&\
	usermod -G containers -a ivpn &&\
	apt-get -y update &&\
	apt-get install -y strongswan libcharon-extra-plugins telnet strongswan-plugin-eap-mschapv2 moreutils &&\
	mkdir -p /home/ivpn/entries/user /home/ivpn/entries/site &&\
	chown -R ivpn /home/ivpn/entries/

#libpam-krb5 krb5-user 

COPY sudoers /etc/sudoers.d/engines
COPY /home/ipsec.conf /etc/
COPY ipsec.secrets /etc/
COPY strongswan.conf /etc/

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

USER ivpn
	
ENV ContUser ivpn

CMD ["/home/start.sh"]