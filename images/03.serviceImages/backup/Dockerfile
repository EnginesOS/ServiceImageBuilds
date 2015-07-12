FROM	engines/servicebase:$release


RUN apt-get -y update;\
	apt-get -y install mysql-client vim  python duply ncftp  python-paramiko python-gobject-2 build-essential gcc make syslogd ;\
	apt-get clean 
ADD etc  etc

RUN echo "Y" | /usr/sbin/usermod -u 22015 -d /home/backup  backup;\
	usermod -G containers -a backup;\ 
	cd /tmp; \
  	wget ftp://ftp.seul.org/pub/fcron/fcron-3.2.0.src.tar.gz;\
  	tar -xzpf fcron-3.2.0.src.tar.gz;\
  	cd fcron-3.2.0;\
  	./configure --with-run-non-privileged --with-rootname=backup\
  	 --without-sendmail\
	--with-rootgroup=backup --with-username=backup --with-groupname=backup\
	--with-etcdir=/home/backup/fcron --with-piddir=/home/backup/fcron\
	--with-fifodir=/home/backup/fcron --with-spooldir=/home/backup/fcron/spool\
	--with-docdir=/home/backup/fcron/doc --prefix=/home/backup/fcron;\
	make install;\
	mkdir -p /home/backup/fcron/doc /home/backup/fcron/man /home/backup/fcron/spool;\
	cd /home/backup;\
	rm -r /tmp/fcron-3.2.0 ;\
	rm /tmp/fcron-3.2.0.src.tar.gz;\	
	mkdir -p /var/log/backup/  /home/sql_dumps;\
	chown -R backup  /home/sql_dumps /var/log/backup/ ;\
	apt-get -y remove  build-essential gcc make ;\
	apt-get -y clean
ADD home home

ADD crontab  /home/backup/fcron/spool/backup.orig
RUN chown -R backup ~backup ;\
	chown backup /home/configurators/saved;\
	chgrp backup /home/configurators/*.sh 
	
COPY sudoers /etc/	
VOLUME /backup_src/volumes
VOLUME /backup_src/engines
VOLUME /local_backup_dests

USER backup
CMD		["/home/init.sh"]



ENV ContUser backup
ENV ContGrp backup
