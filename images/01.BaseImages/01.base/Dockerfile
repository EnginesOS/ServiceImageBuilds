FROM engines/bionicbeaverbase:$release

COPY src/usr/sbin/invoke-rc.d /usr/sbin/

ADD home /home/
	
ENV	build ${BuildDate}

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
 	echo "deb http://security.ubuntu.com/ubuntu bionic-security main restricted universe" >  /etc/apt/sources.list.d/security.list &&\
	apt-get -y update &&\
	apt-get -y upgrade &&\
	apt-get -y dist-upgrade &&\
	apt-get -y update &&\
	/home/engines/scripts/build/no_init.sh &&\
	apt-get -y --fix-missing install sendmail-bin \
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
	 								 unzip \
	 								 curl \
	 								 dnsutils \
	 								 wget \
	 								 bzip2 \
	 								 zlibc  \
	 				   				sudo \
	 				   				libnss-ldap \
	 				   				libpam-ldap \
	 				   				ldap-utils &&\ 
	apt-get -y clean &&\
	mkdir -p /var/run &&\
	mkdir -p /etc/apt/apt.conf.d/ &&\
	dpkg-divert --local --rename --add /sbin/initctl &&\
	rm /sbin/initctl &&\
	ln -s /bin/true /sbin/initctl &&\
	groupadd -g 22020 containers &&\ 
	apt-get -y remove  build-essential &&\
	/home/engines/scripts/build/install_utf8_langauges.sh &&\
	rm -r /tmp/* /home/engines/scripts/build/install_utf8_langauges.sh &&\
	rm /etc/rsyslog.d/50-default.conf &&\ 
	apt-get -y clean &&\	
	rm -rf /tmp/* &&\
 	mkdir /var/run/engines &&\
 	chgrp containers /var/run/engines && chmod g+w /var/run/engines  &&\
	mkdir -p  /home/engines/etc/ssl/CA &&\
	ln -s /home/engines/etc/ssl/CA /usr/share/ca-certificates/engines &&\
 	echo engines/engines_internal_ca.crt >> /etc/ca-certificates.conf
 	 
#COPY src/etc/mail/submit.mc /etc/mail
#COPY src/etc/mail/sendmail.mc /etc/mail
COPY src/ /
RUN	echo y y |sendmailconfig --no-reload &&\ 	
	chmod g+w /var/spool/mqueue &&\
	chmod -R go-rw /etc/sudoers /etc/sudoers.d/system
	
#ADD sudoers /etc/sudoers.d/system
#ADD src/etc/krb5.conf /etc/
#ADD src/etc/rsyslog.conf /etc/		


