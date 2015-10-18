FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl
RUN echo "Y" | adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix
RUN apt-get -y update;\
	apt-get -y install postfix syslogd;\
	apt-get clean;\
	usermod -G containers -a postfix;\
	 ln -s /etc/resolv.conf /var/spool/postfix/etc/;\
	 ln -s /etc/services /var/spool/postfix/etc/
ADD home home

ADD postfix/master.cf /etc/postfix/
ADD postfix/main.cf /etc/postfix/
ADD postfix/mailname /etc/postfix/mailname
ADD postfix/transport /etc/postfix/

RUN chown postfix /etc/postfix/ /etc/postfix/transport /etc/postfix/mailname  ;\
	chown postfix /home/configurators/saved;\
	chgrp postfix /home/configurators/*.sh
	
ADD sudoers /etc/sudoers

   
ENV ContUser postfix
ENV ContGrp postfix
USER postfix


CMD ["/home/start.sh"]