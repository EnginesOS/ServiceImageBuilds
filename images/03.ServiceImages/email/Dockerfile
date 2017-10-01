FROM  engines/servicebase:$release

RUN echo "Y" | adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix &&\
	/home/no_init.sh &&\
	apt-get -y update &&\	
	apt-get -y install postfix \
	                   postfix-pcre \
	                   postfix-ldap \
	                   postgrey \
				       libsasl2-modules-gssapi-mit 
	
ADD home home

RUN cd /tmp/ &&\
	 usermod -G containers -a postfix &&\
	 touch /etc/postfix/smarthost_passwd &&\
	 mkdir /usr/share/doc/postfix/html \
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
	 /usr/sbin/postfix -c /etc/postfix/ set-permissions create-missing ;\
	 cp /etc/resolv.conf /var/spool/postfix/etc/ &&\
	 cp /etc/services /var/spool/postfix/etc/ &&\
	mkdir /etc/postfix/maps &&\
	touch /etc/postfix/maps/smarthost_passwd &&\
	touch /etc/postfix/maps/generic &&\
	postmap hash:/etc/postfix/maps/generic &&\
	postmap hash:/etc/postfix/maps/smarthost_passwd &&\
 	/home/post_build_clean.sh
	
ADD postgrey /etc/default/postgrey
ADD sudoers /etc/sudoers.d/postfix	 

#ADD postfix/main.cf /etc/postfix/
ADD postfix/master.cf /etc/postfix/
ADD postfix/mailname /etc/postfix/mailname
ADD postfix/transport /etc/postfix/maps/transport
ADD postfix/ldap /etc/postfix/ldap

  
RUN postmap /etc/postfix/maps/transport &&\
	chown postfix -R /etc/postfix/maps /home/configurators/saved/ /etc/postfix/mailname &&\
	mkdir -p /home/email /home/configurators/grey/ &&\
	chown postfix /home/email /home/configurators/saved/antispam/ /home/configurators/grey/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/postfix &&\
	cp -rp /var/spool/postfix /tmp/spool_postfix

ENV ContUser postfix
ENV ContGrp postfix

USER postfix

CMD ["/home/start.sh"]