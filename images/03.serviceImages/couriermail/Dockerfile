FROM  engines/apache:$release


RUN echo "Y" | adduser -q --disabled-password -uid 22011 courier ;\
 	mkdir -p /var/run/courier/authdaemon;\
 	mkdir -p /usr/lib/courier/etc/webadmin/;\
 	echo firstpasswd > /usr/lib/courier/etc/webadmin/password;\ 	
 	apt-get -y update;\
 	apt-get -y install libapache2-mod-perl2 libmysqlclient-dev courier-imap-ssl  courier-authlib-mysql courier-pop-ssl courier-ssl courier-webadmin couriergrey ;\
 	/usr/sbin/makealiases;\
 	apt-get clean 
#
 #/usr/lib/courier/libexec/courier/webmail/webadmin nah use apache alias
 # apt-get -y sqwebmail;\	
ADD  000-default.conf /etc/apache2/sites-enabled/	
 	ADD  webadmin-ssl.conf  /etc/apache2/sites-enabled/
RUN 	 cp -rp /usr/lib/courier/courier/webmail/webadmin /usr/lib/cgi-bin;\
		 ln -s /usr/share/courier/webadmin /var/www/html/;\
		 mkdir /var/log/apache2/;\
		 chown www-data /var/log/apache2/;\
		 usermod -G containers -a courier
		 

ENV ContUser courier
ENV ContGrp courier

ADD custom_start.sh /home/engines/scripts/
CMD ["/home/init.sh"]