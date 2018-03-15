FROM engines/servicebase:$release

RUN apt-get -y update &&\
	/home/engines/scripts/build/no_init.sh &&\
	apt-get -y install mysql-client \
	                   vim \
	                   lftp \
	                   python \
	                   duply \ 
	                   python-boto \
	                   ncftp \
	                   python-paramiko \
	                   python-gobject-2 \
	                   build-essential \
	                   gcc \ 
	                   make &&\
	apt-get clean 

ADD src/etc  etc
ADD home home

RUN /usr/sbin/usermod -u 22015 -d /home/backup  backup &&\
	usermod -G containers -a backup &&\ 
	usermod -G root -a backup &&\	 	
	cd /tmp &&\
  	wget ftp://ftp.seul.org/pub/fcron/fcron-3.3.0.src.tar.gz &&\
  	tar -xzpf fcron-3.3.0.src.tar.gz &&\
  	cd fcron-3.3.0 &&\
  	./configure --with-run-non-privileged --with-rootname=backup\
	--with-rootgroup=backup --with-username=backup --with-groupname=backup\
	--with-etcdir=/home/backup/fcron --with-piddir=/home/engines/run/\
	--with-fifodir=/home/backup/fcron --with-spooldir=/home/backup/fcron/spool\
	--with-docdir=/home/backup/fcron/doc --prefix=/home/backup/fcron &&\
	make install &&\
	mkdir -p /home/backup/fcron/doc /home/backup/fcron/man /home/backup/fcron/spool &&\
	cd /home/backup &&\
	rm -r /tmp/fcron-3.3.0 &&\
	rm /tmp/fcron-3.3.0.src.tar.gz &&\	
	mkdir -p /var/log/backup/ /home/backup/sql_dumps &&\
	chown -R backup /home/backup/sql_dumps /var/log/backup/
 

ADD src/crontab  /home/backup/fcron/spool/backup.orig
COPY sudoers /etc/sudoers.d/backup

RUN chown -R backup ~backup &&\
	chown backup /home/engines/scripts/configurators/saved &&\
	chgrp backup /home/engines/scripts/configurators/*.sh &&\
	addgroup --gid 11111 datauser &&\
	usermod -G datauser -a backup &&\
	usermod -G adm -a backup &&\
 	/home/engines/scripts/build/post_build_clean.sh &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/
	
	
	

VOLUME /backup_src/volumes
VOLUME /backup_src/engines
VOLUME /local_backup_dests

USER backup
ENV HOME /home/backup
CMD ["/home/engines/scripts/system/start.sh"]


ENV ContUser backup
ENV ContGrp backup
