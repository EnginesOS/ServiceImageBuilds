FROM engines/servicebase:$release

RUN adduser -q --disabled-password --home /home/app -uid 22033 uadmin &&\
	usermod -G containers -a uadmin &&\
	apt-get -y update &&\
	apt-get -y install libsasl2-modules-gssapi-mit 
	
COPY  home/ /home
COPY sudoers /etc/sudoers.d/uadmin
RUN chmod og-rw /etc/sudoers.d/uadmin

ENV ContUser uadmin
ENV ContGrp uadmin

USER uadmin

CMD ["/home/start.sh"]