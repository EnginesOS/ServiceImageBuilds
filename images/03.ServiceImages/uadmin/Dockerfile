FROM engines/servicebase:$release

RUN adduser -q --disabled-password --home /home/app -uid 22007 uadmin &&\
	usermod -G containers -a uadmin
	


COPY  sudoers /etc/
COPY  home/ /home

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV ContUser uadmin
ENV ContGrp uadmin

USER uadmin

CMD ["/home/start.sh"]