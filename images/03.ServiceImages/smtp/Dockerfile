FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl
RUN echo "Y" | adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix
RUN apt-get -y update;\
	/home/no_init.sh ;\	
	apt-get -y install postfix   ;\
	usermod -G containers -a postfix;\
	 cp /etc/resolv.conf /var/spool/postfix/etc/;\
	 cp /etc/services /var/spool/postfix/etc/;\
 	/home/post_build_clean.sh
ADD home home

ADD postfix/master.cf /etc/postfix/
ADD postfix/main.cf /etc/postfix/
ADD postfix/mailname /etc/postfix/mailname
ADD postfix/transport /etc/postfix/

RUN /usr/sbin/postfix -c /etc/postfix/ set-permissions;\
	postmap /etc/postfix/transport;\
	touch /etc/postfix/transport.smart;\
	touch /etc/postfix/smarthost_passwd;\
	touch /etc/postfix/sender_canonical;\ 
	touch /etc/postfix/generic;\
	chown postfix /etc/postfix/  /etc/postfix/sender_canonical*  /etc/postfix/generic /etc/postfix/generic.db /etc/postfix/smarthost_passwd /etc/postfix/sender_canonical /etc/postfix/smarthost_passwd /etc/postfix/transport /etc/postfix/transport.smart /etc/postfix/transport.db /etc/postfix/mailname  ;\
	chown postfix /home/configurators/saved;\
	chgrp postfix /home/configurators/*.sh
	
ADD sudoers /etc/sudoers.d/smtp

   
ENV ContUser postfix
ENV ContGrp postfix
USER postfix


CMD ["/home/start.sh"]