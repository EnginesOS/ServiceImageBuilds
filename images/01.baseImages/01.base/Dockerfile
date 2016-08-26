#FROM ubuntu:14.04
FROM engines/base_image:alpha 

ENV DEBIAN_FRONTEND noninteractive

COPY invoke-rc.d /usr/sbin/
COPY sendmail /usr/bin/

ADD sources.list /etc/apt/

ADD home /home/
	
ENV	build 20160827
	
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ED8E640A;\
	apt-get -y  --force-yes update;\
	apt-get -y  --force-yes dist-upgrade;\
	apt-get -y  --force-yes update;\
	/home/no_init.sh ;\
	apt-get -y  --fix-missing install build-essential   unzip curl dnsutils git  wget bzip2 zlibc sendEmail;\ 
	apt-get clean;\
	mkdir -p /var/run;\
	mkdir -p /etc/apt/apt.conf.d/;\
	dpkg-divert --local --rename --add /sbin/initctl;\
	ln -s /bin/true /sbin/initctl;\
	ln -s /usr/bin/sendmail /usr/sbin/sendmail;\
	groupadd -g 22020 containers ;\ 
	cd  /tmp ;\
	git clone https://github.com/zserge/jsmn ;\
	cd jsmn ;\
	make ;\
	cp -r /home/src . ;\
	cd src ;\
	make json_to_env ;\
	mkdir -p /home/engines/bin;\
	cp json_to_env /home/engines/bin;\
	rm -r /home/src ;\
	apt-get remove  build-essential;\
	/home/install_utf8_langauges.sh;\
	rm -r /tmp/* /home/install_utf8_langauges.sh
	 

#increment build line to trigger upgrade NEED to Automate



RUN		apt-get clean ;\
		apt-get autoremove ;\
		apt-get autoclean ;\		
		rm -rf /tmp/*;\
 		mkdir /var/run/engines ; chgrp containers /var/run/engines; chmod g+w /var/run/engines	
		
CMD ["/home/init.sh"]