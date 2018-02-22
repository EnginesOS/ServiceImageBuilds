FROM  engines/servicebase:$release

RUN adduser -q --disabled-password --home /home/cron -uid 22016 cron &&\
	groupadd -g 999 docker &&\
	usermod -G docker -a cron &&\
	usermod -G containers -a cron &&\
	apt-get  update &&\
	apt-get -y install build-essential \
	                   gcc \
	                   make &&\
	cd /tmp &&\
  	wget ftp://ftp.seul.org/pub/fcron/fcron-3.3.0.src.tar.gz &&\
  	tar -xzpf fcron-3.3.0.src.tar.gz &&\
  	cd fcron-3.3.0 &&\
  	./configure --with-run-non-privileged --with-rootname=cron\
	--with-rootgroup=cron --with-username=cron --with-groupname=cron\
	--with-piddir=/home/engines/run\
	--with-fifodir=/home/cron --with-spooldir=/home/cron/spool\
	--with-docdir=/home/cron/doc --prefix=/home/cron &&\
	make install &&\
	mkdir -p /home/cron/doc /home/cron/man /home/cron/spool /home/cron/log/ &&\
	chown -R cron /home/cron/ &&\
	cd /home/cron &&\
 	/home/post_build_clean.sh

COPY home home


USER cron
	
ENV ContUser cron

CMD ["/home/engines/scripts/startup/start.sh"]