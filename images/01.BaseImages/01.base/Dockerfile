FROM engines/xenialbase:$release
#FROM engines/base_image:alpha 

ENV DEBIAN_FRONTEND noninteractive

COPY invoke-rc.d /usr/sbin/

ADD home /home/
	
ENV	build 20180215
RUN	echo '#!/bin/sh' >/usr/sbin/policy-rc.d &&\
	echo exit 101 >> /usr/sbin/policy-rc.d &&\
	chmod +x /usr/sbin/policy-rc.d &&\
	dpkg-divert --local --rename --add /sbin/initctl &&\
	cp -a /usr/sbin/policy-rc.d /sbin/initctl &&\
	echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup &&\
	echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean &&\
	echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean &&\
	echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean &&\
	echo 'Acquire::GzipIndexes "true";Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes &&\
	sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list &&\
 	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ED8E640A&&\
	apt-get -y update &&\
	apt-get -y upgrade &&\
	apt-get -y dist-upgrade &&\
	apt-get -y update &&\
	/home/engines/scripts/build/no_init.sh &&\
	apt-get -y --fix-missing install ldap-utils \
			           			     ca-certificates \
		 						     krb5-user \
	 								 krb5-config \
	 								 libsasl2-modules-gssapi-mit \
	 								 expect-lite \
	 								 rsyslog \
	 								 git \
	 								 language-pack-en-base \
	 								 apt-file \
	 								 software-properties-common \
	 								 build-essential \
	 								 unzip \
	 								 curl \
	 								 dnsutils \
	 								 wget \
	 								 bzip2 \
	 								 zlibc &&\ 
	apt-get -y clean &&\
	mkdir -p /var/run &&\
	mkdir -p /etc/apt/apt.conf.d/ &&\
	dpkg-divert --local --rename --add /sbin/initctl &&\
	rm /sbin/initctl &&\
	ln -s /bin/true /sbin/initctl &&\
	groupadd -g 22020 containers &&\ 
	cd  /tmp &&\
	git clone https://github.com/zserge/jsmn &&\
	cd jsmn &&\
	make &&\
	cp -r /home/src . &&\
	cd src &&\
	make json_to_env &&\
	mkdir -p /home/engines/bin&&\
	cp json_to_env /home/engines/bin &&\
	rm -r /home/src &&\
	apt-get -y remove  build-essential &&\
	/home/engines/scripts/build/install_utf8_langauges.sh &&\
	rm -r /tmp/* /home/engines/scripts/build/install_utf8_langauges.sh &&\
	rm /etc/rsyslog.d/50-default.conf &&\ 
	apt-get -y clean &&\	
	rm -rf /tmp/* &&\
 	mkdir /var/run/engines &&\
 	chgrp containers /var/run/engines && chmod g+w /var/run/engines 

ADD krb5.conf /etc/
ADD rsyslog.conf /etc/		
