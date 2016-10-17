FROM engines/servicebase:$release
COPY kadm5.acl /etc/
COPY krb5.conf /etc/
RUN echo "Y"| adduser --uid 22010 -q --home /home/ftpd --disabled-password proftpd;\
	/home/no_init.sh ;\	
	apt-get  update;\
  	apt-get -y install proftpd proftpd-mod-mysql     libpam-krb5;\
	usermod -G containers -a proftpd;\
 	/home/post_build_clean.sh


COPY proftpd /etc/proftpd/
ADD sudoers /etc/sudoers

RUN mkdir /ftp/;\
	chgrp proftpd /etc/proftpd/sql.conf ;\
	chmod g+w /etc/proftpd/sql.conf ;\
	ln -s /home/.ssh /home/ftpd/
	
ADD home home

USER proftpd
ENV ContUser proftpd
CMD ["/home/start.sh"]