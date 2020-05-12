FROM engines/bionicbeaverbase:$release

COPY src/ /

RUN	echo "deb http://security.ubuntu.com/ubuntu bionic-security main restricted universe" >  /etc/apt/sources.list.d/security.list &&\ 	
	apt-get -y update &&\
	apt-get -y upgrade &&\
	/home/engines/scripts/build/no_init.sh &&\
	apt-get -y --fix-missing install sendmail-bin \
			           			     ca-certificates \
			           			     sudo \
	 								 expect-lite \
	 								 language-pack-en-base \
	 								 apt-file \
	 								 software-properties-common \
	 								 git \
	 								 unzip \
	 								 curl \
	 								 dnsutils \
	 								 wget \
	 								 bzip2 \
	 								 zlibc  \
	 								 rsyslog \
		 						     krb5-user \
	 								 krb5-config \
	 								 libsasl2-modules-gssapi-mit \
	 				   				libnss-ldap \
	 				   				libpam-ldap \
	 				   				ldap-utils &&\ 
	apt-get -y remove  build-essential &&\
	apt-get -y clean &&\	
	rm -rf /tmp/* &&\
	/home/engines/scripts/build/engines_system_init.sh


