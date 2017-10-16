FROM engines/servicebase:$release

#COPY kadm5.acl /etc/
COPY krb5.conf /etc/

RUN adduser --uid 22010 -q --home /home/ftpd --disabled-password proftpd &&\
	/home/no_init.sh &&\	
	apt-get -y update &&\
  	apt-get -y install proftpd \
				       libsasl2-2  \
				       libsasl2-modules-gssapi-mit \
				       libsasl2-modules-ldap \
  					   proftpd-mod-ldap &&\
	usermod -G containers -a proftpd &&\
	ln -s /home/ftpd /run/proftpd &&\
 	/home/post_build_clean.sh

COPY proftpd /etc/proftpd/
ADD sudoers /etc/sudoers.d/ftp

RUN mkdir /ftp/ &&\
	mkdir -p /home/home_dir/.ssh &&\
	ln -s /home/home_dir/.ssh /home/ftpd/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	
ADD home home

USER proftpd

ENV ContUser proftpd

CMD ["/home/start.sh"]