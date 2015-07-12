FROM engines/servicebase:$release
COPY kadm5.acl /etc/
COPY krb5.conf /etc/
RUN echo "Y"| adduser --uid 22010 -q --home /home/ftpd --disabled-password proftpd;\
 	apt-get -y update;\
  	apt-get -y install proftpd proftpd-mod-mysql syslogd  libpam-krb5;\
	apt-get clean;\
	usermod -G containers -a proftpd


COPY proftpd /etc/proftpd/
ADD sudoers /etc/sudoers

RUN mkdir /ftp/;\
	chgrp proftpd /etc/proftpd/sql.conf ;\
	chmod g+w /etc/proftpd/sql.conf
	
ADD home home

USER proftpd

CMD ["/home/init.sh"]