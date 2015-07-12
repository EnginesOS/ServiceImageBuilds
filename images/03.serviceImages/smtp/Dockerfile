FROM engines/servicebase:$release
Maintainer image.maintainer@engines.onl
RUN echo "Y" | adduser -q --disabled-password --home /var/spool/postfix -uid 22003 postfix
RUN apt-get -y update;\
	apt-get -y install postfix syslogd;\
	apt-get clean;\
	usermod -G containers -a postfix
ADD home home

ADD postfix/main.cf /etc/postfix/
ADD postfix/master.cf /etc/postfix/
ADD postfix/mailname /etc/postfix/mailname

RUN chown postfix /etc/postfix/;\
	chown postfix /home/configurators/saved;\
	chgrp postfix /home/configurators/*.sh
	
ADD sudoers /etc/sudoers

   
ENV ContUser postfix
ENV ContGrp postfix
USER postfix


CMD ["/home/init.sh"]