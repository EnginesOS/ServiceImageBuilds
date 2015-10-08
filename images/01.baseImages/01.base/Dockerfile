#FROM ubuntu:14.04
FROM engines/base_image:alpha 

ENV DEBIAN_FRONTEND noninteractive

COPY invoke-rc.d /usr/sbin/
COPY sendmail /usr/bin/

ADD sources.list /etc/apt/

RUN apt-get -y  --force-yes update;\
	apt-get -y  --force-yes upgrade;\
	apt-get -y  --force-yes update;\
	apt-get -y  --fix-missing install   unzip curl dnsutils git  wget bzip2 zlibc sendEmail;\ 
	apt-get clean;\
	mkdir -p /var/run;\
	mkdir -p /etc/apt/apt.conf.d/;\
	dpkg-divert --local --rename --add /sbin/initctl;\
	ln -s /bin/true /sbin/initctl;\
	apt-get clean;\
	ln -s /usr/bin/sendmail /usr/sbin/sendmail;\
	groupadd -g 22020 containers ;\
	apt-mark hold tzdata

ADD init.sh /home/
ADD trap.sh /home/

#increment build line to trigger upgrade
ENV	build 20150515

RUN 	apt-get -y  --force-yes update;\
		apt-get upgrade -y;\
		apt-get clean ;\
		rm -f /usr/sbin/initctl /usr/sbin/invoke-rc.d /usr/sbin/restart /usr/sbin/start /usr/sbin/stop /usr/sbin/start-stop-daemon /usr/sbin/service;\
		ln -s /bin/true /usr/sbin/initctl;\
		ln -s /bin/true /usr/sbin/invoke-rc.d;\
		ln -s /bin/true /usr/sbin/restart;\
		ln -s /bin/true /usr/sbin/stop;\
		ln -s /bin/true /usr/sbin/start;\
		ln -s /bin/true /usr/sbin/start-stop-daemon;\
		ln -s /bin/true /usr/sbin/service
		
CMD ["/home/init.sh"]