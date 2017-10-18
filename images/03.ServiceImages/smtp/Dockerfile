FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl
RUN adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix &&\
	apt-get -y update &&\
	/home/no_init.sh &&\	
	apt-get -y install postfix &&\
	usermod -G containers -a postfix &&\
	cp /etc/resolv.conf /var/spool/postfix/etc/ &&\
	cp /etc/services /var/spool/postfix/etc/ &&\
 	/home/post_build_clean.sh

ADD home home
ADD src/postfix/master.cf /etc/postfix/
ADD src/postfix/main.cf /etc/postfix/
ADD src/postfix/mailname /etc/postfix/mailname
ADD src/postfix/transport /etc/postfix/

RUN mkdir /usr/share/doc/postfix/html \
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
	 	  	/etc/postfix/main.cf.proto \
	 	  	/etc/postfix/makedefs.out \
	 	  	/etc/postfix/master.cf.proto \
	 	  	/etc/postfix/postfix-files.d \
	 	  	/usr/lib/postfix/libglobal &&\
	 		touch /etc/postfix/generic.db \
	 		/etc/postfix/transport.smart \
	 		/etc/postfix/smarthost_passwd \
	 		/etc/postfix/sender_canonical \
	 	    /etc/postfix/generic && \
	/usr/sbin/postfix -c /etc/postfix/ set-permissions create-missing ;\
	postmap /etc/postfix/transport &&\
	chown postfix /etc/postfix/ /etc/postfix/sender_canonical* /etc/postfix/generic /etc/postfix/generic.db /etc/postfix/smarthost_passwd /etc/postfix/sender_canonical /etc/postfix/smarthost_passwd /etc/postfix/transport /etc/postfix/transport.smart /etc/postfix/transport.db /etc/postfix/mailname &&\
	chown postfix /home/engines/scripts/configurators/saved /home/postfix &&\
	chgrp postfix /home/engines/scripts/configurators/*.sh &&\
	cp -rp /var/spool/postfix /tmp/spool_postfix
	
ADD sudoers /etc/sudoers.d/smtp

RUN	chmod -R go-rw /etc/sudoers /etc/sudoers.d/

ENV ContUser postfix
ENV ContGrp postfix

USER postfix

CMD ["/home/start.sh"]