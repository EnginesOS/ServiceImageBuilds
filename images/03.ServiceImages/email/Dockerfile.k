FROM  engines/servicebase:k

RUN groupadd -g 22003 postfix&&\
	useradd -u 22003  -g postfix -d /var/spool/postfix -m -G containers postfix&&\
	/home/engines/scripts/build/no_init.sh &&\
	apt-get -y update &&\	
	apt-get -y install postfix \
	                   postfix-pcre \
	                   postfix-ldap \
	                   postgrey \
	                   opendkim \
	                   opendkim-tools \
	                   postfix-policyd-spf-python \
				       libsasl2-modules-gssapi-mit 
	
ADD home home

RUN cd /tmp/ &&\
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
	 	  	postfix-policyd-spf-python \
	 	  	/etc/postfix/dynamicmaps.cf.d \
	 	  	/etc/postfix/makedefs.out \
	 	  	/etc/postfix/postfix-files.d \
	 	  	/usr/lib/postfix/libglobal &&\
	 /usr/sbin/postfix -c /etc/postfix/ set-permissions create-missing ;\
	 cp /etc/resolv.conf /var/spool/postfix/etc/ &&\
	 cp /etc/services /var/spool/postfix/etc/ &&\
	mkdir /etc/postfix/maps &&\
 	/home/engines/scripts/build/post_build_clean.sh
	
ADD src/postgrey /etc/default/postgrey
ADD sudoers /etc/sudoers.d/postfix	 


ADD src/postfix/master.cf /etc/postfix/
ADD src/postfix/mailname /etc/postfix/mailname 

  
RUN chown postfix -R /home/engines/scripts/configurators/saved/ /etc/postfix/mailname &&\
	mkdir -p /home/email /home/engines/scripts/configurators/grey/ &&\
	chown postfix /home/email /home/engines/scripts/configurators/saved/antispam/ /home/engines/scripts/configurators/grey/ &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/postfix &&\
	cp -rp /var/spool/postfix /tmp/spool_postfix 

ENV ContUser postfix
ENV ContGrp postfix

USER postfix

CMD ["/home/engines/scripts/system/start.sh"]