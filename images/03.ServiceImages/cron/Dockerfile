FROM  engines/servicebase:$release

COPY home home

COPY src/fcron.conf /home/cron/etc/

RUN groupadd -g 22016 cron &&\
	useradd -u 22016  -g cron -d /home/cron -m -G containers cron&&\
	apt-get  update &&\
	apt-get -y install build-essential \
					   vim  \
	                   gcc \
	                   make &&\
	cd /tmp &&\
  	wget http://fcron.free.fr/archives/fcron-3.2.1.src.tar.gz &&\
  	tar -xzpf fcron-3.2.1.src.tar.gz &&\
  	cd fcron-3.2.1 &&\
  	./configure --with-run-non-privileged --with-rootname=cron\
		--with-rootgroup=cron --with-username=cron --with-groupname=cron\
		--with-piddir=/home/engines/run\
		--with-fifodir=/home/cron --with-spooldir=/home/cron/spool\
		--with-docdir=/home/cron/doc --prefix=/home/cron &&\
	make install &&\
	rm -r /tmp/fcron-3.2.1 &&\
	rm /tmp/fcron-3.2.1.src.tar.gz &&\
	mkdir -p /home/cron/doc /home/cron/man /home/cron/spool /home/engines/scripts/configurators/saved/ /home/cron/log/ &&\
	chown -R cron /home/cron/ /home/engines/scripts/configurators/saved/ &&\
	cd /home/cron &&\
	chown root /home/cron/etc/fcron.conf &&\
	chmod og-w /home/cron/etc/fcron.conf &&\
 	/home/engines/scripts/build/post_build_clean.sh


USER cron
	
ENV ContUser cron

CMD ["/home/engines/scripts/system/start.sh"]