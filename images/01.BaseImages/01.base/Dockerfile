FROM engines/bionicbeaverbase:$release

COPY src/ /

RUN	echo "deb http://security.ubuntu.com/ubuntu bionic-security main restricted universe" >  /etc/apt/sources.list.d/security.list &&\ 	
	apt-get -y update &&\
	apt-get -y upgrade &&\
	apt-get -y dist-upgrade &&\
	apt-get -y update &&\
	/home/engines/scripts/build/no_init.sh &&\
	apt-get -y --fix-missing install sendmail-bin \
			           			     ca-certificates \
			           			     sudo \
	 								 expect-lite \
	 								 language-pack-en-base \
	 								 apt-file \
	 								 software-properties-common \
	 								 rsyslog \
	 								 git \
	 								 unzip \
	 								 curl \
	 								 dnsutils \
	 								 wget \
	 								 bzip2 \
	 								 zlibc  \
		 						     krb5-user \
	 								 krb5-config \
	 								 libsasl2-modules-gssapi-mit \
	 				   				libnss-ldap \
	 				   				libpam-ldap \
	 				   				ldap-utils &&\ 
	mkdir -p /var/run &&\
	mkdir -p /etc/apt/apt.conf.d/ &&\
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


RUN	 chmod -R go-w /etc/mail/ &&\
	echo y y |sendmailconfig --no-reload &&\
	chmod g+w /var/spool/mqueue &&\
	chmod -R go-rw /etc/sudoers 


