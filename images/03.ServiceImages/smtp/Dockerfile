FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl
RUN useradd -u 22003  -g postfix -d /var/spool/postfix -m -G containers postfix &&\
	apt-get -y update &&\
	/home/engines/scripts/build/no_init.sh &&\	
	apt-get -y install postfix &&\
	cp /etc/resolv.conf /var/spool/postfix/etc/ &&\
	cp /etc/services /var/spool/postfix/etc/ &&\
 	/home/engines/scripts/build/post_build_clean.sh

RUN mkdir 	/home/postfix \
			/usr/share/doc/postfix/html \
	 	  	/usr/lib/postfix/libutil \
	 	  	/usr/lib/postfix/libmaster \
	 	  	/usr/lib/postfix/libdns \
	 	  	/usr/lib/postfix/libtls \
	 	  	/usr/lib/postfix/cdb \
	 	  	/usr/lib/postfix/ldap \
	 	  	/usr/lib/postfix/lmdb \
	 	  	/usr/lib/postfix/mysql \
	 	  	/usr/lib/postfix/pcre \
	 	  	/usr/lib/postfix/pgsql \
	 	  	/usr/lib/postfix/sdbm \
	 	  	/usr/lib/postfix/sqlite \
	 	  	/etc/postfix/dynamicmaps.cf.d \
	 	  	/etc/postfix/makedefs.out \
	 	  	/etc/postfix/postfix-files.d \
	 	  	/usr/lib/postfix/libglobal  && \
	/usr/sbin/postfix -c /etc/postfix/ create-missing set-permissions ;\
	echo dirs setup 
	

ADD sudoers /etc/sudoers.d/smtp

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ADD src/postfix/master.cf /etc/postfix/
ADD src/postfix/main.cf /etc/postfix/
ADD src/postfix/mailname /etc/postfix/mailname

ADD home home
RUN	mkdir -p /home/engines/scripts/configurators/saved &&\
	chown postfix /home/postfix/ &&\
	chown postfix /home/engines/scripts/configurators/saved /home/postfix &&\
	chgrp postfix /home/engines/scripts/configurators/*.sh &&\
	cp -rp /var/spool/postfix /tmp/spool_postfix

ENV ContUser postfix
ENV ContGrp postfix

USER postfix

CMD ["/home/engines/scripts/system/start.sh"]