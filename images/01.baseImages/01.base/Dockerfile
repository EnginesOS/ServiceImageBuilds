#FROM ubuntu:14.04
FROM engines/base_image:alpha 

ENV DEBIAN_FRONTEND noninteractive

COPY invoke-rc.d /usr/sbin/
COPY sendmail /usr/bin/

ADD sources.list /etc/apt/

ADD init.sh /home/
ADD trap.sh /home/
ADD no_init.sh /home/
ADD src /home/

RUN apt-get -y  --force-yes update;\
	apt-get -y  --force-yes upgrade;\
	apt-get -y  --force-yes update;\
	/home/no_init.sh ;\
	apt-get -y  --fix-missing install build-essential   unzip curl dnsutils git  wget bzip2 zlibc sendEmail;\ 
	apt-get clean;\
	mkdir -p /var/run;\
	mkdir -p /etc/apt/apt.conf.d/;\
	dpkg-divert --local --rename --add /sbin/initctl;\
	ln -s /bin/true /sbin/initctl;\
	apt-get clean;\
	ln -s /usr/bin/sendmail /usr/sbin/sendmail;\
	groupadd -g 22020 containers ;\
	apt-mark hold tzdata ;\
	cd  /tmp ;\
	 git clone https://github.com/zserge/jsmn ;\
	 cd jsmn ;\
	 make ;\
	 cp -r /home/src . ;\
	 cd src ;\
	 make json_to_env ;\
	 cp json_to_env /home/engines/scripts
	 #apt-remove ... build-essential 



#increment build line to trigger upgrade NEED to Automate
ENV	build 20151005

RUN 	apt-get -y  --force-yes update;\
		apt-get upgrade -y;\
		apt-get clean 	
		
		
CMD ["/home/init.sh"]