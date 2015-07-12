FROM  engines/servicebase:$release
RUN apt-get -y update;\
	echo "Y" | adduser -q --disabled-password --home /home/cron -uid 22016 cron;\
	groupadd -g 999 docker;\
	usermod -G docker -a cron ;\
	usermod -G containers -a cron ;\
	apt-get -y install build-essential gcc make syslogd;\
	apt-get clean ;\
	cd /tmp; \
  	wget ftp://ftp.seul.org/pub/fcron/fcron-3.2.0.src.tar.gz;\
  	tar -xzpf fcron-3.2.0.src.tar.gz;\
  	cd fcron-3.2.0;\
  	./configure --with-run-non-privileged --with-rootname=cron\
  	 --without-sendmail\
	--with-rootgroup=cron --with-username=cron --with-groupname=cron\
	--with-piddir=/home/cron\
	--with-fifodir=/home/cron --with-spooldir=/home/cron/spool\
	--with-docdir=/home/cron/doc --prefix=/home/cron;\
	make install;\
	mkdir -p /home/cron/doc /home/cron/man /home/cron/spool /home/cron/log/;\
	chown -R cron /home/cron/;\
	cd /home/cron;\
	rm -r /tmp/fcron-3.2.0 ;\
	rm /tmp/fcron-3.2.0.src.tar.gz ;\
	apt-get -y remove  build-essential gcc make ;\
	apt-get -y clean 



COPY home home
COPY sudoers /etc/	
USER cron

CMD ["/home/init.sh"]