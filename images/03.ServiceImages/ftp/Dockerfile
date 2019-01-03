FROM engines/servicebase:$release

RUN groupadd -g 22010 proftpd &&\
	useradd -u 22010  -g proftpd -d /home/ftpd -m -G containers proftpd&&\
	/home/engines/scripts/build/no_init.sh &&\	
	apt-get -y update &&\
  	apt-get -y install proftpd \
				       libsasl2-2  \
				       libsasl2-modules-gssapi-mit \
				       libsasl2-modules-ldap \
  					   proftpd-mod-ldap &&\
	ln -s /home/ftpd /run/proftpd &&\
 	/home/engines/scripts/build/post_build_clean.sh

COPY src/proftpd /etc/proftpd/
ADD sudoers /etc/sudoers.d/ftp

RUN mkdir /ftp/ &&\
	mkdir -p /home/home_dir/.ssh &&\
	ln -s /home/home_dir/.ssh /home/ftpd/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	
ADD home home

USER proftpd

ENV ContUser proftpd

CMD ["/home/engines/scripts/system/start.sh"]